class AddMyMemberOnOwnGroup
  include Interactor

  def setup
    context.fail! unless context[:group].present?
  end

  def perform
    context[:group].members.create(user: context[:user])

    unless context[:group].users.include? context[:user]
      context.fail!
    end
  end
end
