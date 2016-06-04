class PersistGame
  include Interactor

  def setup
    context.fail! if context.game.blank?
  end

  def call
    unless context.game.update context.params
      context.fail!
    end
  end
end
