class AddMetadataToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :metadata, :text
  end
end
