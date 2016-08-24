class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lesson, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true
      t.references :word_answer, index: true, foreign_key: true
      t.boolean :is_correct
      t.timestamps null: false
    end
  end
end
