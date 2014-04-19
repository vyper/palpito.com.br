class FindOrInviteUser
  include Interactor

  def setup
    context[:member].present? and context[:member].valid?
  end

  def perform
    email = context[:member].email
    user = User.where(email: email).first

    if user.blank?
      User.invite! email: email
      user = User.where(email: email).first
    end

    context[:user] = user
  end
end
