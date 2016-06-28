Rails.application.routes.draw do

  get 'passwords/create'

  get 'passwords/new'

  post 'support' => 'friendships#support', as: :support
  # post 'unsupport' => 'friendships#unsupport', as: :unsupport

  post 'add_user' => 'friendships#add_user', as: :add_user
  post 'removed_user' => 'friendships#removed_user', as: :removed_user
  post 'remove_friend' => 'friendships#remove_friend', as: :remove_friend

  resources :posts do
    resources :comments
  end

  get 'events/sitemap' => 'events#sitemap'
  #get 'events/find_location' => 'events#find_location'

  resources :events  do
    resources :posts
  end

  resources :volunteers

  resources :user_pictures

  resources :contacts, only: [:new, :create]

  # get 'welcome/index'
  # get 'email_messages/new' => 'email_messages#new', as: :new_email_messages
  #post 'events/create'=> 'events#create'
  #get 'events/:id' => 'events#show', as: :event
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}
  devise_scope :user do
    get 'registrations/profile_settings' => 'registrations#profile_settings', as: :profile_settings
    get 'registrations/edit_user' => 'registrations#edit_user'
    get 'registrations/edit_location' => 'registrations#edit_location'
    get 'registrations/edit_description' => 'registrations#edit_description'
    get 'registrations/edit_email' => 'registrations#edit_email'
    get 'registrations/edit_phone' => 'registrations#edit_phone'
    post 'registrations/update_user' => 'registrations#update_user'
    post 'registrations/update_location' => 'registrations#update_location'
    post 'registrations/update_description' => 'registrations#update_description'
    post 'registrations/update_email' => 'registrations#update_email'
    post 'registrations/update_phone' => 'registrations#update_phone'
    post 'registrations/update_settings' => 'registrations#update_settings'
    post 'registrations/update' => 'registrations#update'
    post 'registrations/update_password' => 'registrations#update_password'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'events#index'
  # get 'events/join_volunteer'=> 'events#join_volunteer', as: :join_volunteer
  get 'join_volunteer' => 'events#join_volunteer', as: :join_volunteer
  get 'disjoin_volunteer' => 'events#disjoin_volunteer', as: :disjoin_volunteer
  post 'accept_friend_request' => 'friendships#accept_friend_request', as: :accept_friend_request
  post 'deny_friend_request' => 'friendships#deny_friend_request', as: :deny_friend_request
  get 'contacts/new', :to => 'contacts#new'
  get 'inbox_notifications' => 'email_messages#index', as: :inbox_notifications
  post 'email_messages' => 'email_messages#email_message'
  post 'contact', :to => 'contacts#contact'
  get 'event_list', :to => 'events#event_list'
  post 'email_message_detail' => 'email_messages#email_message_detail', as: :email_message_detail
  post 'send_message_reply' => 'email_messages#send_message_reply', as: :send_message_reply
  get 'email_message_detail' => 'email_messages#email_message_detail'
  get 'friendsearch_request' => 'events#friendsearch_request'
  get 'search_users' => 'events#search_users'
  get 'glisSupportPage' =>  'friendships#glisSupportPage', as: :glisSupportPage

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :events

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
