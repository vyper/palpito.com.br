class AddDefaultToStatusOnMembers < ActiveRecord::Migration[4.2]
  def up
    change_column :members, :status, :integer, default: 2
  end

  def down
    change_column :members, :status, :integer, default: nil
  end
end
