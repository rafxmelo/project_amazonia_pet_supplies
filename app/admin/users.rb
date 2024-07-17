ActiveAdmin.register User do
  permit_params :username, :email, :address, :province_id

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
