class CreateLayers < ActiveRecord::Migration[6.0]
  def change
    create_table :layers do |t|
      t.integer :inputs
      t.integer :outputs
      t.string :weights
      t.integer :perceptron_id

      t.timestamps
    end

    add_index :layers, :perceptron_id
  end
end