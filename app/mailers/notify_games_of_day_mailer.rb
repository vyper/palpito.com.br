class NotifyGamesOfDayMailer < ActionMailer::Base
  default from: 'leonardo@palpito.com.br'

  def notify(user_id)
    @user = User.find(user_id)
    @games = Game.
               of_day.
               joins(championship: { groups: :members }).
               where(members: { user_id: @user.id })
    mail(to: @user.email, subject: subject)
  end

  private

  def subject
    '[palpito.com.br] ' +
    [
      'E não é que hoje tem jogo?',
      'Não esqueceu do seu palpite, né?',
      'Ixi, não lembro se você palpitou hoje',
      'Run Forrest, run!',
      'Tem palpite para os jogos de hoje?'
    ].sample
  end
end
