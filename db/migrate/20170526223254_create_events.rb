class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user_classroom, index: true, foreign_key: true
      t.integer :kids
      t.integer :adults
      t.date :date

      t.timestamps
    end
  end
end
