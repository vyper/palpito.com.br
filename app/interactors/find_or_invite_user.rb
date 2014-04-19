class FindOrInviteUser
  include Interactor

  def setup
    context.fail! if context[:member].blank? or not context[:member].valid?
  end

  def perform
    email = context[:member].email
    user = User.where(email: email).first
    context[:user_invited] = false

    if user.blank?
      User.invite! email: email
      context[:user_invited] = true
      user = User.where(email: email).first
    end

    context[:user] = user
  end
end
