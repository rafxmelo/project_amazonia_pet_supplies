class AddDefaultHstRateToOrders < ActiveRecord::Migration[7.1]
  def up
    # Set a default value for existing orders
    Order.where(hst_rate: nil).update_all(hst_rate: 0.0)

    # Ensure the column has a default value in the future
    change_column_default :orders, :hst_rate, 0.0
  end

  def down
    change_column_default :orders, :hst_rate, nil
  end
end
