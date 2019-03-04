class CartsCreationDateChangeValueFromNull < ActiveRecord::Migration[5.0]
  def change  
    execute %Q(
      UPDATE carts
      SET creation_date='2000-01-01 00:00:00'
      WHERE creation_date IS NULL
    )
  end
end
