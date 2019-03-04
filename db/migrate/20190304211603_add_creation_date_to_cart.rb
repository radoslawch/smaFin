class AddCreationDateToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :creation_date, :datetime
  end
end
