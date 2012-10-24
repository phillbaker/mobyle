Ihub::Application.routes.draw do
  get 'm/:private_id' => 'hubs#mobile_private', :as => 'private_mobile_hub'
  
  resources :hubs do
    resources :groups do
      resources :contacts
      resources :file_uploads
      
      #  TODO would like the name to be NEW_hub_group_subgroup...
      get 'new' => 'groups#new', :as => 'subgroup' #/hubs/:hub_id/groups/:group_id/new
      member do 
        get 'import'
        post 'upload'
      end
    end
    
    member do
      get 'mobile'
    end
  end

  # TODO for newsletter subscription/etc. => /unsubscribe?email=pbaker%40retrodict.com&validateCode=IBZBD
  devise_for :users
  scope "/users" do
    post '/invite' => 'users#invite_by_newsletter', :as => 'user_invite'
    #TODO get 'demo' => 'users#evaluate' #or #try ?
  end
  
  scope "/admin" do
    #TODO do non-nested resources for all objects so admin can go in and fix, or support can go in and manually add stuff for folks
    resources :users
    resources :uploads
  end

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
