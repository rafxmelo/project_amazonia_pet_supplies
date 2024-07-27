# config/routes/active_storage.rb
Rails.application.routes.draw do
  direct :rails_storage_proxy do |model, options|
    route_for(:rails_storage_proxy, model.signed_id, model.filename, options)
  end

  direct :rails_storage_redirect do |model, options|
    route_for(:rails_storage_redirect, model.signed_id, model.filename, options)
  end

  scope Rails.configuration.active_storage.routes_prefix do
    get  "/blobs/redirect/:signed_id/*filename" => "active_storage/blobs#show", as: :rails_storage_redirect
    get  "/blobs/:signed_id/*filename" => "active_storage/blobs#show", as: :rails_storage_proxy
    get  "/representations/redirect/:signed_blob_id/:variation_key/*filename" => "active_storage/representations#show", as: :rails_blob_representation_redirect
    get  "/representations/:signed_blob_id/:variation_key/*filename" => "active_storage/representations#show", as: :rails_blob_representation_proxy
    get  "/disk/:encoded_key/*filename" => "active_storage/disk#show", as: :rails_disk_service
    put  "/disk/:encoded_token" => "active_storage/disk#update", as: :update_rails_disk_service
    post "/direct_uploads" => "active_storage/direct_uploads#create", as: :rails_direct_uploads
  end
end
