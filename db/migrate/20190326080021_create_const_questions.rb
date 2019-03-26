class CreateConstQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :const_questions do |t|
      t.text :text
      t.string :vector
      t.string :basics
      t.integer :const_answer_id

      t.timestamps
    end
    add_index :const_questions, :const_answer_id
  end
end
