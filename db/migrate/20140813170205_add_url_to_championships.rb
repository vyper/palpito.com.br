class AddUrlToChampionships < ActiveRecord::Migration[4.2]
  def change
    add_column :championships, :url, :string
  end
end
