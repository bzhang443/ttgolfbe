Ttgolfbe::Application.routes.draw do

  devise_for :admins

  root :to => "oss#home"
  
  match 'oss' => "oss#home"
  get 'oss/area_list'
  get 'oss/course_list' 
  get 'oss/course_info'
  get 'oss/all_logos'
  
  match 'api' => 'api#index'
  post "api/sign_up"
  post "api/sync_config"
  post "api/config_user"
  post "api/switch_user"
  post "api/find_password"
  get "api/hot_list"
  get "api/course_list"
  get "api/course_info"
  post "api/comment_course"
  post "api/add_favorite"
  get "api/my_favorites"
  get "api/my_comments"
  get "api/area_list"
  get "api/fairway_list"
  get "api/fairway_map"
  get 'api/search_suggest'
  get 'api/key_search'
  get 'api/map_search'
  post 'api/sina_share'
  post 'api/reset_password'
  get 'api/credit_history'
  get 'api/my_scorecards'
  get 'api/scorecard_info'
  post 'api/save_scorecard'
  post 'api/add_feedback'
  post 'api/upload_photo'
  
  get "callback/sina"
  
  resources :feedbacks
  resources :comments
  resources :favorites
  resources :users
  resources :devices
  resources :prices
  resources :agents
  resources :images
  resources :maps
  resources :holes
  resources :courses
  resources :clubs
  resources :areas
  resources :credit_histories  
  resources :score_cards
  
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
