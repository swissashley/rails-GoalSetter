class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.date :completion_date, null: false
      t.boolean :is_private, null: false, default: false

      t.timestamps null: false
    end
  end
end
