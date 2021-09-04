class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :followee, null:false, foreign_key: { to_table: :users }
      t.references :follower, null:false, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:followee_id, :follower_id], unique: true
    end
  end
end
