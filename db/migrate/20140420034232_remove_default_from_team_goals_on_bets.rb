class RemoveDefaultFromTeamGoalsOnBets < ActiveRecord::Migration[4.2]
  def up
    change_column :bets, :team_home_goals, :integer, null: true
    change_column :bets, :team_away_goals, :integer, null: true
  end

  def down
    change_column :bets, :team_home_goals, :integer, null: false
    change_column :bets, :team_away_goals, :integer, null: false
  end
end
