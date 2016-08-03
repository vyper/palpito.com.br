class AddBasePointsToChampionships < ActiveRecord::Migration[5.0]
  def change
    add_column :championships, :points_base, :integer, default: 10
  end
end
