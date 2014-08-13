class AddIndexToExternalIdOnGames < ActiveRecord::Migration
  def change
    add_index :games, :external_id
  end
end
