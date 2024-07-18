### app/admin/pages.rb ###
ActiveAdmin.register Page do
  permit_params :title, :content

  form do |f|
    f.inputs 'Page Details' do
      f.input :title
      f.input :content, as: :quill_editor
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :content
      row :created_at
      row :updated_at
    end
  end
end
