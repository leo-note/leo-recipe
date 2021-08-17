class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer    :gender_id,           null:false
      t.integer    :family_structure_id, null:false
      t.integer    :taste_id,            null:false
      t.references :user,                null: false,foreign_key: true 
      t.timestamps
    end
  end
end
