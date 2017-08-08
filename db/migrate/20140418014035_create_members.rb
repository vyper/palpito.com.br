class CreateMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :members do |t|
      t.references :championship, null: false, index: true
      t.references :group,        null: false, index: true
      t.references :user,         null: false, index: true
      t.integer    :status,       null: false

      t.timestamps
    end
  end
end
