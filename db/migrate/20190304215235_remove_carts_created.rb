class RemoveCartsCreated < ActiveRecord::Migration[5.0]
  def change
    remove_column :carts, :created
  end
end
