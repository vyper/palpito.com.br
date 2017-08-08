class AddChampionshipToGroups < ActiveRecord::Migration[4.2]
  def change
    add_reference :groups, :championship, index: true
  end
end
