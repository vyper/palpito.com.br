class MemberMailer < ActionMailer::Base
  default from: 'leonardo@palpito.com.br'

  def invite(member)
    @member = member

    mail(to: @member.email, subject: 'Instruções para convite recebido')
  end
end
