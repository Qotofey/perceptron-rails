class CreatePerceptrons < ActiveRecord::Migration[6.0]
  def change
    create_table :perceptrons do |t|
      t.integer :size
      t.float :coefficient, precision: 1, scale: 8

      t.timestamps
    end
  end
end
