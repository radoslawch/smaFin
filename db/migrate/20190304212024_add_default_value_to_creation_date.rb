class AddDefaultValueToCreationDate < ActiveRecord::Migration[5.0]
  def up
    change_column_null :carts, :creation_date, :datetime, false
    change_column_default :carts, :creation_date, '2000-01-01 00:00:00'
  end
end
