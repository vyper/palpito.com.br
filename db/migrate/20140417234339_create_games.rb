class CreateGames < ActiveRecord::Migration[4.2]
  def change
    create_table :games do |t|
      t.datetime   :played_at,       null: false
      t.integer    :team_home_goals
      t.integer    :team_away_goals
      t.references :team_home,       null: false, index: true
      t.references :team_away,       null: false, index: true
      t.references :round,           null: false, index: true

      t.timestamps
    end
  end
end
