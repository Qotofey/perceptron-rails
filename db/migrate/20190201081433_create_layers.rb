class CreateLayers < ActiveRecord::Migration[6.0]
  def change
    create_table :layers do |t|
      t.integer :size_inputs
      t.integer :size_outputs
      t.string :weights
      t.string :inputs
      t.string :outputs
      t.integer :perceptron_id

      t.timestamps
    end

    add_index :layers, :perceptron_id
  end
end