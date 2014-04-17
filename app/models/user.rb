class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## validations
  validates :nickname,   presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :team,       presence: true

  ## associations
  belongs_to :team

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
end
