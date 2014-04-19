class AddDefaultToStatusOnMembers < ActiveRecord::Migration
  def up
    change_column :members, :status, :integer, default: 2
  end

  def down
    change_column :members, :status, :integer, default: nil
  end
end
