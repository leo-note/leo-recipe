class CreateAllergyMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :allergy_materials do |t|
      t.references   :allergy,  null: false,foreign_key: true
      t.references   :material, null: false,foreign_key: true
      t.timestamps
    end
  end
end
