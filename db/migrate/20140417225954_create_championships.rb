class CreateChampionships < ActiveRecord::Migration
  def change
    create_table :championships do |t|
      t.string   :name,        null: false
      t.datetime :started_at,  null: false
      t.datetime :finished_at, null: false

      t.timestamps
    end
  end
end
