class CreateConstAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :const_answers do |t|
      t.text :text
      t.string :vector

      t.timestamps
    end
  end
end
