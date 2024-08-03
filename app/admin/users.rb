ActiveAdmin.register User do
  permit_params :username, :email, :address, :province_id, :encrypted_password

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :address
    column :province
    column :encrypted_password
    actions
  end

  filter :username
  filter :email
  filter :address
  filter :province
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :address
      f.input :province
    end
    f.actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :address
      row :province
      row :created_at
      row :updated_at
      row :encrypted_password
    end

    panel "Orders" do
      table_for user.orders do
        column :id
        column :total_amount
        column :status
        column :created_at
        column :updated_at
        column "Order Details" do |order|
          link_to "View Order", admin_order_path(order)
        end
      end
    end
  end
end
