class ChangeStatusTypeInOrders < ActiveRecord::Migration[6.1]
  def up
    # Change the column type to integer
    change_column :orders, :status, :integer, default: 0, null: false

    # Manually set existing records to a known state if they have nil status
    Order.where(status: nil).update_all(status: 0) # Set to :new_order as default
  end

  def down
    # Revert the changes if necessary
    change_column :orders, :status, :string
  end
end
