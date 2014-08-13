class AddChampionshipToGames < ActiveRecord::Migration
  def change
    add_reference :games, :championship, index: true
    Game.all.each { |game| game.update championship_id: game.round.championship_id }
  end
end
