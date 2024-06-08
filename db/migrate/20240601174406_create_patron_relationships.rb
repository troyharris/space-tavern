class CreatePatronRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :patron_relationships do |t|
      t.references :patron, null: false, foreign_key: true
      t.references :other_patron, null: false, foreign_key: { to_table: :patrons }
      t.float :affinity, null: false, default: 0.5
      t.string :shared_history

      t.timestamps
    end
  end
end
