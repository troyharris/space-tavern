class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :day, null: false
      t.integer :time, null: false
      t.string :type, null: false
      t.string :message
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
