class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :value
      t.string :vector

      t.timestamps
    end
  end
end
