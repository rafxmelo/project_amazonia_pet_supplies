ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :products_count do |category|
      category.products.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :products_count do |category|
        category.products.count
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  sidebar "Products in this category", only: :show do
    table_for category.products do
      column :name
      column :price
      column :stock_quantity
    end
  end
end
