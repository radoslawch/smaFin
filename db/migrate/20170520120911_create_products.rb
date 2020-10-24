class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :hidden, default: false
      t.references :subcategory, foreign_key: true
      t.string :unit

      t.timestamps
    end
  end
end
