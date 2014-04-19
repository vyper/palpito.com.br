class InviteUserToGroup
  include Interactor

  def setup
    context.fail! if context[:group].blank? or context[:user].blank?
  end

  def perform
    group  = context[:group]
    user   = context[:user]
    status = user == group.admin ? Member::statuses[:active] : Member::statuses[:invited]

    member = group.members.create(user: user, status: status)
    unless group.users.include? user
      context.fail!
    end

    context[:member] = member
  end
end
