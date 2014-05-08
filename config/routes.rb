
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # Authentication
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations],
                     controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  as :user do
    # session handling
    get     '/entrar'  => 'devise/sessions#new',     as: 'new_user_session'
    post    '/entrar'  => 'devise/sessions#create',  as: 'user_session'
    delete  '/sair' => 'devise/sessions#destroy', as: 'destroy_user_session'

    # joining
    get   '/cadastrar' => 'devise/registrations#new',    as: 'new_user_registration'
    post  '/cadastrar' => 'devise/registrations#create', as: 'user_registration'

    scope '/minha-conta' do
      # password reset
      get   '/perdi-a-senha'       => 'devise/passwords#new',    as: 'new_user_password'
      put   '/perdi-a-senha'       => 'devise/passwords#update', as: 'user_password'
      post  '/perdi-a-senha'       => 'devise/passwords#create'
      get   '/perdi-a-senha/mudar' => 'devise/passwords#edit',   as: 'edit_user_password'

      # confirmation
      get   '/confirmacao'         => 'devise/confirmations#show',   as: 'user_confirmation'
      post  '/confirmacao'         => 'devise/confirmations#create'
      get   '/confirmacao/renviar' => 'devise/confirmations#new',    as: 'new_user_confirmation'

      # settings & cancellation
      get '/cancelar'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get '/meus-dados' => 'devise/registrations#edit',   as: 'edit_user_registration'
      put '/meus-dados' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'
    end
  end

  resources :groups, path: '/grupos', except: [:show] do
    put :classify, on: :member
    resources :members, path: '/participantes', only: [:index, :destroy]

    resource :member, path: '/participante', only: [] do
      get    '/novo'     => 'members#new',    as: 'new'
      post   '/convidar' => 'members#invite', as: 'invite'
      put    '/aceitar'  => 'member#accept',  as: 'accept'
      delete '/'         => 'member#destroy', as: 'destroy'
    end
  end

  resources :bets, only: [:index, :update]

  resources :championships, except: :show

  resources :rounds, except: :show

  resources :games, except: :show

  get '/sobre'       => 'pages#about', as: 'about'
  get '/regulamento' => 'pages#rule',  as: 'rule'

  root to: 'bets#index'
end
