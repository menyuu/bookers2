class AddRateToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rate, :string, default: 0.0, null: false
  end
end
