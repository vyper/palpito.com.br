class RemoveChampionshipFromMembers < ActiveRecord::Migration[4.2]
  def up
    remove_column :members, :championship_id
  end

  def down
    change_table :members do |t|
      t.references :championship
    end
  end
end
