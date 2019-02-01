class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :text
      t.string :vector
      t.string :basics
      t.integer :answer_id

      t.timestamps
    end
    add_index :questions, :answer_id
  end

end
