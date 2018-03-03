class Users::FacebookController < Doorkeeper::ApplicationController
  protect_from_forgery with: :null_session

  # Verify better way to make this auth );
  def create
    uri = URI("https://graph.facebook.com/#{params[:uid]}?fields=first_name,last_name,email&access_token=#{params[:access_token]}")
    info = JSON.parse(Net::HTTP.get(uri))

    oauth = OpenStruct.new(
      info: OpenStruct.new(info),
      provider: :facebook,
      uid: params[:uid]
    )

    user = User.from_facebook_oauth(oauth)
    sign_in user, event: :authentication

    auth = authorization.authorize
    auth.token.update resource_owner_id: user.id
    render json: auth.body, status: auth.status
  end

  private

  def authorization
    @authorization ||= strategy.request
  end

  def strategy
    @strategy ||= server.token_request params[:grant_type]
  end
end
