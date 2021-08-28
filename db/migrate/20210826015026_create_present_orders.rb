class CreatePresentOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :present_orders do |t|
      t.integer    :present_id, null: false
      t.references :user,       null: false,foreign_key: true
      t.timestamps
    end
  end
end
