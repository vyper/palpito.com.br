class NotifyGamesOfDayWorker
  include Sidekiq::Worker

  def perform
    users.each do |user|
      NotifyGamesOfDayMailer.delay.notify(user.id)
    end
  end

  private

  def users
    @users ||= User.
                 joins(members: { group: { championship: :games } }).
                 merge(Game.of_day).
                 merge(User.confirmed).
                 merge(Member.active).
                 uniq
  end
end
