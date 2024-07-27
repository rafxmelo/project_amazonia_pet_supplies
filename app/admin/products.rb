# app/admin/products.rb
ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :on_sale, :image, category_ids: []

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale
      f.input :image, as: :file
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :on_sale
      row :created_at
      row :updated_at
      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image)
        else
          content_tag(:span, "No image attached")
        end
      end
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :on_sale
    column :created_at
    column :updated_at
    column :categories do |product|
      product.categories.map(&:name).join(", ")
    end
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :on_sale, as: :select
  filter :created_at
  filter :updated_at
  filter :categories
end
