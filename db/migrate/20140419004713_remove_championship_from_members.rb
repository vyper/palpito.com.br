class RemoveChampionshipFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :championship_id
  end

  def down
    change_table :members do |t|
      t.references :championship
    end
  end
end
