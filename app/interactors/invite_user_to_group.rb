class InviteUserToGroup
  include Interactor

  def setup
    context.fail! if context[:group].blank? or context[:user].blank?
  end

  def perform
    group  = context[:group]
    user   = context[:user]
    status = user == group.admin ? Member::statuses[:active] : Member::statuses[:invited]

    member = group.members.where(user: user).first
    if member.blank?
      member = group.members.create(user: user, status: status)

      unless group.users.include? user
        context.fail!
      end

      if member.invited? and not context[:user_invited]
        MemberMailer.invite(member).deliver
      end
    end

    context[:member] = member
  end
end
