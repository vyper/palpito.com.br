class AddChampionshipToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :championship, index: true
  end
end
