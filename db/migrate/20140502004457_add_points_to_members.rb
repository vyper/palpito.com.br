class AddPointsToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :points, :integer,  null: false, default: 0
  end
end
