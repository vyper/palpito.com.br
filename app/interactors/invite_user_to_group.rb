class InviteUserToGroup
  include Interactor

  def setup
    context.fail! if context.group.blank? or context.user.blank?
  end

  def call
    group = context.group
    user  = context.user

    member = group.members.where(user: user).first
    if member.blank?
      member = group.members.create(user: user, status: status)

      unless group.users.include? user
        context.fail!
      end

      if member.invited? and not context.user_invited
        MemberMailer.invite(member).deliver
      end
    end

    context.member = member
  end

  def status
    group  = context.group
    user   = context.user

    if user === group.admin
      return Member::statuses[:active]

    elsif not user.confirmed?
      return Member::statuses[:active]

    else
      return Member::statuses[:invited]
    end
  end
end
