class CreateTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :teams do |t|
      t.string     :name
      t.string     :short_name
      t.attachment :image

      t.timestamps
    end
  end
end
