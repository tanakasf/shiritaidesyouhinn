class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :explanation, null: false
      t.boolean :is_enabled, default: true, null: false

      t.timestamps
    end
  end
end
