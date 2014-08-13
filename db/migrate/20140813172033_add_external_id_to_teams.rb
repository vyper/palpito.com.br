class AddExternalIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :external_id, :string
  end
end
