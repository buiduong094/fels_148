class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :word, foreign_key: true
      t.string :content
      t.boolean :is_correct
      t.timestamps
    end
    add_index :answers, [:word_id, :created_at]
  end
end
