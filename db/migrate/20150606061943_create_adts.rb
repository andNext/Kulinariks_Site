class CreateAdts < ActiveRecord::Migration
  def change
    create_table :adts do |t|
      t.string :about
      t.integer :user_id
      t.integer :cost
      t.string :spare
      t.string :marka
      t.string :city

      t.timestamps
    end
    add_index :adts, [:user_id, :created_at]
  end
end
