# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params :status, :user_id, :total_amount, order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :user do |order|
      order.user.username
    end
    column "Products" do |order|
      order.order_items.map { |item| item.product.name }.join(", ")
    end
    column "Taxes" do |order|
      gst = order.total_amount * order.user.province.gst / 100.0
      pst = order.total_amount * order.user.province.pst / 100.0
      qst = order.total_amount * order.user.province.qst / 100.0
      "GST: #{number_to_currency(gst)}, PST: #{number_to_currency(pst)}, QST: #{number_to_currency(qst)}"
    end
    column :total_amount do |order|
      number_to_currency(order.total_amount)
    end
    column :status do |order|
      status = order.status&.humanize || 'Unknown'
      status_tag(status, class: order.status || 'unknown')
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :total_amount
  filter :status, as: :select, collection: Order.statuses.keys
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :user
      row :total_amount
      row :status do |order|
        order.status&.humanize || 'Unknown'
      end
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end

    panel "Taxes" do
      gst = order.total_amount * order.user.province.gst / 100.0
      pst = order.total_amount * order.user.province.pst / 100.0
      qst = order.total_amount * order.user.province.qst / 100.0
      "GST: #{number_to_currency(gst)}, PST: #{number_to_currency(pst)}, QST: #{number_to_currency(qst)}"
    end

    panel "Grand Total" do
      number_to_currency(order.total_amount)
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :total_amount
      f.input :status, as: :select, collection: Order.statuses.keys.map { |status| [status.humanize, status] }
      f.has_many :order_items, allow_destroy: true do |item|
        item.input :product
        item.input :quantity
        item.input :price
      end
    end
    f.actions
  end
end
