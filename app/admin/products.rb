ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
    end
    f.actions
  end
end
