class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.integer :facebook_user_id
      t.integer :response_set_id
      t.string :student_type
      t.string :gender
      t.string :year
     end
  end

  def down
    drop_table :students
  end
end
