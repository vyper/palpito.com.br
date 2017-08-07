class AddChampionshipToGames < ActiveRecord::Migration[4.2]
  def change
    add_reference :games, :championship, index: true
  end
end
