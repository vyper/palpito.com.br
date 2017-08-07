class AddIndexToExternalIdOnTeams < ActiveRecord::Migration[4.2]
  def change
    add_index :teams, :external_id
  end
end
