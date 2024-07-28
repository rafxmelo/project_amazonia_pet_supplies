ActiveAdmin.register Order do
  permit_params :status, :province_id, order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]

  filter :province, as: :select, collection: -> { Province.all.pluck(:name, :id) }
  filter :status

  index do
    selectable_column
    id_column
    column :user
    column :province
    column :total_amount
    column :status
    column :created_at
    column :updated_at
    column "Order Items" do |order|
      ul do
        order.order_items.each do |item|
          li "#{item.product.name} (Quantity: #{item.quantity}, Price: #{item.price})"
        end
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :status
      f.input :province, as: :select, collection: Province.all.pluck(:name, :id)
      f.has_many :order_items, allow_destroy: true do |item|
        item.input :product
        item.input :quantity
        item.input :price
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :province
      row :total_amount
      row :status
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column "Product" do |item|
          item.product.name
        end
        column "Quantity" do |item|
          item.quantity
        end
        column "Price" do |item|
          item.price
        end
      end
    end
  end
end
