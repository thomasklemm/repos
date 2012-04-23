Repos::Application.routes.draw do
  
  # mercury editor
  # custom mercury controller to allow :name to have dots in it, explanation see below
  match '/editor/repo/:owner/:name' => "my_mercury#edit", :as => :mercury_editor, :constraints => { :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  Mercury::Engine.routes

  # Index
  get "repo" => "repo#index", :as => :repo

  # Show repo using pretty urls full of meaning
  get 'repo/:owner/:name' => 'repo#show', :constraints => { :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  # get 'repo/:id' => 'repo#show'

  # Add repo
  get 'repo/add' => 'repo#add_repo'

  # Mercury
  post 'repo/:owner/:name/' => 'repo#mercury_and_tags_update', :constraints => { :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }



  # 'Repos' uses routes that might contain dots in name "eg. list.js, visibility.js ..."
  # This needs special settings for every route that has the param :name in it

  # Version 1:
  # routing constraint setting allowing .js names among other "everything except '/' and .html and .json"
  # :constraints => { :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  # source: http://stackoverflow.com/questions/8059655/authentication-with-mercury-rails

  # Version 2:
  # name: /[^\/]+/
  # takes everything except '/', source: Rails guides



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
  # root :to => 'welcome#index'
  root :to => 'repo#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
