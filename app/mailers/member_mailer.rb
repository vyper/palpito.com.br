class MemberMailer < ActionMailer::Base
  default from: "bolao@mcorp.io"

  def invite(member)
    @member = member

    mail(to: @member.email, subject: "Instruções para convite recebido")
  end
end
