class AddExternalIdToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :external_id, :string
  end
end
