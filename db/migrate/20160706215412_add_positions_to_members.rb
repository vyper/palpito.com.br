class AddPositionsToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :position,  :integer, null: false, default: 0
    add_column :members, :positions, :jsonb,   null: false, default: {}
  end
end
