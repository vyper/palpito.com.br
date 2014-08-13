class AddIndexToExternalIdOnTeams < ActiveRecord::Migration
  def change
    add_index :teams, :external_id
  end
end
