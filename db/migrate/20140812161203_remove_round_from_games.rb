class RemoveRoundFromGames < ActiveRecord::Migration
  def change
    remove_reference :games, :round
  end
end
