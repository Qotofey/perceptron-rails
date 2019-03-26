class CreatePerceptrons < ActiveRecord::Migration[6.0]
  def change
    create_table :perceptrons do |t|
      t.integer :size
      t.decimal :coefficient

      t.timestamps
    end
  end
end
