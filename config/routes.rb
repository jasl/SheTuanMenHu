Website::Application.routes.draw do

  resources :groups do
    resources :articles
    resources :pages, :except => [:index]
    resources :members, :only => [:new, :create, :destroy]

    collection do
        match ":id/manage/articles" => 'manage#articles', :as => :manage_articles
        match ":id/manage/pages" => 'manage#pages', :as => :manage_pages
        match ":id/manage/" => 'manage#index', :as => :manage
        match ":id/manage/control" => 'manage#control', :as => :manage_control
    end
    get '/join' => 'members#join', :as => :join
    post '/modify_members' => 'members#modify', :as => :modify_members
  end

=begin
  namespace :attachment, :only => [:index, :create, :destroy] do
    resources :pictures
    resources :files
  end
=end
  namespace :attachment, :only => [:index, :create, :destroy] do
    resources :pictures
    resources :files
  end

  resources :profiles
  resources :users

  #result
  post '/search' => 'groups#index'

  #regist
  get '/register' => 'users#new'
  #login
  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  #logout
  get '/logout' => 'user_sessions#destroy'

  #change password
  get '/password' => 'users#index'
  #profile
  get '/my_profile' => 'profiles#index'
  #apply a protal
  get '/apply' => 'groups#new'

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
  # match ':controller(/:action(/:id(.:format)))'
end
