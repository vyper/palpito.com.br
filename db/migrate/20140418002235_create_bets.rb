class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :user,            null: false, index: true
      t.references :game,            null: false, index: true
      t.integer    :team_home_goals, null: false
      t.integer    :team_away_goals, null: false
      t.integer    :points

      t.timestamps
    end
  end
end
