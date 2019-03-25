class AddCountToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :count, :integer
  end
end
