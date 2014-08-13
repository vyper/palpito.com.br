class AddUrlToChampionships < ActiveRecord::Migration
  def change
    add_column :championships, :url, :string
  end
end
