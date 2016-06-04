class PersistGame
  include Interactor

  def setup
    context.fail! if context.game.blank?
  end

  def call
    unless game.update context.params
      context.fail!
    end

    context.game = game
  end
end
