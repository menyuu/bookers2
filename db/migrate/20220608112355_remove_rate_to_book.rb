class RemoveRateToBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :rate, :float, default: 0.0, null: false
  end
end
