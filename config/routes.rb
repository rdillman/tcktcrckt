Tcktcrckt::Application.routes.draw do
  get "validator/val"

  get "validator/enter"

  get "alert/show"
  # match "/show" => "alert/show", :as => :alert
  get "alert/create"

  get "alert/kill"

  get "lookup/addr"
  # match "/lookup" => "lookup#addr", :as => :lookup
  
  get "lookup/home"
  
  get "lookup/get_next_time"
  # match "/time" => "lookup#get_next_time", :as => :lookup
  
  get "lookup/delete_alert"
  
  get "lookup/change_alert"
  
  get "lookup/make_alert"

  get "lookup/map"
  
  get "mapz/how_to"
  
  get "mapz/home"
  
  get "mapz/timecnn"
  
  get "alert/show_alerts_on_map"
  
  get "mapz/timequery"
  
  get "alert/beef"
  
  get "alert/show"
  
  get "alert/update_phone"
  
  get "alert/make_new_alert"
  
  get "alert/timecnn"
  
  get "alert/timequery"
  
  get "alert/recent_alerts"

  resources :authentications
  ActiveAdmin.routes(self)


  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  match '/auth/:provider/callback', :to => 'authentications#create'
  
  # Links
  get "mapz/about_us"
  get "mapz/contact_us"
  get "mapz/tos"
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "mapz#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
