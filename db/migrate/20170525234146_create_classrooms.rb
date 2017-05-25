class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.string :teacher_name
      t.string :grade_level
      t.integer :number_of_students_enrolled
      t.references :school, index: true, foreign_key: true

      t.timestamps
    end
  end
end
