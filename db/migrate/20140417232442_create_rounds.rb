class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string     :name,         null: false
      t.references :championship, null: false, index: true

      t.timestamps
    end
  end
end
