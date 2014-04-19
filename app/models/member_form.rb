# TODO: create a path for 'forms'?
class MemberForm
  include ActiveModel::Model

  ## attributes
  attr_accessor :email, :group

  ## validations
  validates :email, presence: true
  validates :group, presence: true
end
