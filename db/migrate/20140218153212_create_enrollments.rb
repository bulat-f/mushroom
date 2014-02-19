class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :learning_course_id
      t.boolean :confirmed

      t.timestamps
    end

    add_index :enrollments, :user_id
    add_index :enrollments, :learning_course_id
    add_index :enrollments, [:user_id, :learning_course_id], unique: true
  end
end
