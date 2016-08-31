
class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.boolean :is_complete, default: false
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
    add_index :lessons, [:user_id, :created_at]
  end
end
