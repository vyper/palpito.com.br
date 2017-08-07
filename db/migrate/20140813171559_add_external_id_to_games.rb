class AddExternalIdToGames < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :external_id, :string
  end
end
