ActiveAdmin.register Order do
  permit_params :status, order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]

  form do |f|
    f.inputs do
      f.input :status
      f.has_many :order_items, allow_destroy: true do |item|
        item.input :product
        item.input :quantity
        item.input :price
      end
    end
    f.actions
  end
end
