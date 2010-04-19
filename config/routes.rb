ActionController::Routing::Routes.draw do |map|
  map.resources :carreras

  map.resources :tags

  map.resources :institucions

  map.resources :alternativas, :collection => {:update_edit => :get }

  map.resources :respuestas

  map.resources :evaluacions, :collection => {:resultado => :get, :graph_code_radar => :get, :resultadoxls => :get }

  map.resources :preguntas, :collection => {:eliminar_edit => :get }

  map.resources :rasgos

  map.resources :pruebas, :collection => {:orquestar_create => :get, :orquestar_update => :get }

  map.resources :usuarios
  
  map.resources :main, :collection => {:login => :get, :principal => :get, :tablero => :get, :logout => :get}

  map.resources :reportes, :collection => {:panel => :get, :promedio => :post, :dominancia => :post, :promediosxls => :get, :dominanciaxls => :get, :graph_code_radar => :get }

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "main", :action => "login"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
