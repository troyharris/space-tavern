class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :description
      t.integer :day, null: false, default: 1
      t.string :history
      t.float :tavern_popularity, null: false, default: 0.1
      t.float :colony_prosperity, null: false, default: 0.1
      t.integer :credits, null: false, default: 100
      t.integer :beer_cost, null: false, default: 5
      t.integer :beer_sell_price, null: false, default: 10
      t.integer :beers_in_stock, null: false, default: 10
      t.datetime :current_time, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.float :event_probability, null: false, default: 0.7
      t.boolean :is_event_triggered, null: false, default: false

      t.timestamps
    end
  end
end
