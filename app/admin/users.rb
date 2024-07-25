ActiveAdmin.register User do
  permit_params :username, :email, :address, :province_id

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :address
    column :province
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
end
