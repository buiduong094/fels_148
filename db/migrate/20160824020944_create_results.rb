class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :word_answer_id
      t.integer :word_id
      t.references :lesson, foreign_key: true
      t.timestamps
    end
  end
end
