class AddPointsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :points, :integer,  null: false, default: 0
  end
end
