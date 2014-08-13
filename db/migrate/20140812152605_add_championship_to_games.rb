class AddChampionshipToGames < ActiveRecord::Migration
  def change
    add_reference :games, :championship, index: true
  end
end
