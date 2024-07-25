ActiveAdmin.register Province do
  permit_params :name, :gst, :pst, :qst

  index do
    selectable_column
    id_column
    column :name
    column :gst
    column :pst
    column :qst
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst
      f.input :pst
      f.input :qst
    end
    f.actions
  end
end
