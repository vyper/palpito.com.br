class RemoveRoundFromGames < ActiveRecord::Migration[4.2]
  def change
    remove_reference :games, :round
  end
end
