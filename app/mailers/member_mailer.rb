class MemberMailer < ActionMailer::Base
  default from: "leonardo@papodeboleiro.com"

  def invite(member)
    @member = member

    mail(to: @member.email, subject: "Instruções para convite recebido")
  end
end
