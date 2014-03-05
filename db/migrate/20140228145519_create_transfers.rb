class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.decimal :amount
      t.string  :message, limit: 128

      t.timestamps
    end
    
    add_index :transfers, :sender_id
    add_index :transfers, :recipient_id
  end
end
