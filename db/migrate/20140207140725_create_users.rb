class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :surname, limit: 64
      t.string :name, limit: 64
      t.string :patronymic, limit: 64
      t.boolean :sex
      t.string :email
      t.string :phone, limit: 32
      t.decimal :wallet
      t.boolean :tutor
      t.boolean :admin

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
