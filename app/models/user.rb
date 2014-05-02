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

  def facebooked?
    provider.present? and uid.present?
  end

  def self.from_facebook_oauth(auth)
    user = where(email: auth.info.email).first_or_create

    unless user.facebooked?
      user.provider = auth.provider
      user.uid      = auth.uid
    end

    unless user.persisted?
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.email      = auth.info.email
      user.nickname   = user.name[0..15]
      user.password   = Devise.friendly_token[0,20]
    end

    user.save if user.changed?

    user
  end
end
