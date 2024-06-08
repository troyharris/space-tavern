class CreatePatrons < ActiveRecord::Migration[7.1]
  def change
    create_table :patrons do |t|
      t.string :name, null: false
      t.string :job, null: false
      t.integer :credits, null: false
      t.string :description, null: false
      t.integer :age, null: false
      t.float :enjoys_tavern, null: false, default: 0.1
      t.boolean :is_visiting, null: false, default: false
      t.integer :visit_length, null: false, default: 0
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
