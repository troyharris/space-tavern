class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.integer :day, null: false
      t.integer :time, null: false
      t.string :event_type, null: false
      t.string :description, null: false
      t.boolean :is_visiting, null: false, default: false
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
