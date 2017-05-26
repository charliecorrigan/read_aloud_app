class CreateUserClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :user_classrooms do |t|
      t.references :user, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true

      t.timestamps
    end
  end
end
