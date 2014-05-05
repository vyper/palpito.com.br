class ScheduleGameClassify
  include Interactor

  def setup
    context.fail! if context[:game].blank?
  end

  def perform
    game = context[:game]

    if game.goals?
      ClassifyGameWorker.perform_at game.played_at + 10.minutes, game.id
    end
  end
end
