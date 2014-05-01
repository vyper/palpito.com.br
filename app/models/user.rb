class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable,
         :omniauthable, :omniauth_providers => [:facebook]

  ## validations
  validates :nickname,   presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :team,       presence: true

  ## associations
  belongs_to :team
  has_many :bets
  has_many :members
  has_many :my_groups, class_name: Group, foreign_key: :admin_id
  has_many :groups, through: :members

  ## methods
  def name
    "#{first_name} #{last_name.to_s.first}."
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    nickname
  end

  def self.find_for_facebook_oauth(auth)
    binding.pry
    params = auth.slice(:provider, :uid).merge(email: auth.info.email)
    user = where("email = :email OR (provider = :provider AND uid = :uid)", params).first_or_create do |u|
      u.provider   = auth.provider
      u.uid        = auth.uid
      u.email      = auth.info.email
      u.password   = Devise.friendly_token[0,20]
      u.first_name = auth.info.first_name
      u.last_name  = auth.info.last_name
    end
    # # TODO improve this
    # user = where(email: auth.info.email).first
    # user = where(provider: auth.provider, uid: auth.uid).first unless user

    # unless user
    #   user = User.create provider: auth.provider,
    #                      uid: auth.uid,
    #                      email: auth.info.email,
    #                      name: auth.extra.raw_info.name,
    #                      password: Devise.friendly_token[0,20]
    # end

    # user

    # where(auth.slice(:provider, :uid)).first_or_create do |user|
    #   user.provider = auth.provider
    #   user.uid = auth.uid
    #   user.email = auth.info.email
    #   user.password = Devise.friendly_token[0,20]
    #   binding.pry
    #   user.first_name = auth.info.first_name
    #   user.last_name  = auth.info.last_name
    # end
  end
end
