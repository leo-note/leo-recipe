class CreateRecipeMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_materials do |t|
      t.string     :amount,    null: false
      t.references :recipe,    null: false,foreign_key: true
      t.references :material , null: false,foreign_key: true
      t.timestamps
    end
  end
end
