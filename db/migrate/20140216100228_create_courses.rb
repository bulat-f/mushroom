class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :subject
      t.integer :hours
      t.text :describtion
      t.decimal :price
      t.integer :tutor_id

      t.timestamps
    end
  end
end
