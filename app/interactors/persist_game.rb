class PersistGame
  include Interactor

  def setup
    context.fail! if context[:game].blank?
  end

  def perform
    unless game.update params
      context.fail!
    end

    context[:game] = game
  end
end
