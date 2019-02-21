Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :fb_catalogs do 
    	resources :fb_exports, as: :exports
    end
    put :send_catalog, to: 'fb_exports#send_catalog'
    post :update_catalog_status, to: 'fb_exports#update_catalog_status'
    resources :fb_settings
  end
end