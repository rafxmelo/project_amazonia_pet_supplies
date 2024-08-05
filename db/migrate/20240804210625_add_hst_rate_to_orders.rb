class AddHstRateToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :hst_rate, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
