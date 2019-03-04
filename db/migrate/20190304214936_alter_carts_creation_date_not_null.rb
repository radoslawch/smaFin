class AlterCartsCreationDateNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :carts, :creation_date, false
  end
end
