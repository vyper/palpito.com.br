class AddIndexToExternalIdOnGames < ActiveRecord::Migration[4.2]
  def change
    add_index :games, :external_id
  end
end
