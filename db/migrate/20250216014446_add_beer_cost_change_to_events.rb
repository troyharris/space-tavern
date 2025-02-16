class AddBeerCostChangeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :beer_cost_change, :integer, default: 0
  end
end
