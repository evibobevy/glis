Rails.application.routes.draw do

  # get 'foundations/new'
  # # get 'foundations/create'
  # get 'foundations/:id' => 'foundations#edit'
  # post 'foundations/:id' => 'foundations#edit'

  get 'passwords/create'

  get 'passwords/new'

  post 'support' => 'friendships#support', as: :support
  post 'unsupport' => 'friendships#unsupport', as: :unsupport
  post 'spread_post' => 'friendships#spread_post', as: :spread_post

  post 'add_user' => 'friendships#add_user', as: :add_user
  post 'removed_user' => 'friendships#removed_user', as: :removed_user
  post 'remove_friend' => 'friendships#remove_friend', as: :remove_friend

  post 'user_support' => 'foundation_friendships#user_support', as: :user_support
  post 'user_unsupport' => 'foundation_friendships#user_unsupport', as: :user_unsupport
  post 'spread_user_post' => 'foundation_friendships#spread_user_post', as: :spread_user_post
  get "/users/sign_in" => redirect("/")
  resources :posts do
    resources :comments
  end

  get 'events/sitemap' => 'events#sitemap'
  get 'join_gigs' => 'events#join_gigs', as: :join_gigs

  resources :events  do
    resources :posts
  end
  resources :foundations  do
    resources :posts
  end

  resources :volunteers
  resources :foundations, except: :index
  resources :foundation_pictures
  post 'foundation_pictures/update' => 'foundation_pictures#update', as: :foundations_update
  get 'foundation_calendar', :to => 'foundations#foundation_calendar'
  # post 'foundation_calendar', :to => 'foundations#foundation_calendar'
  # get 'foundations/user_foundations' => 'foundations#user_foundations'
  # get 'foundations/:id' => 'foundations#foundation_profile', as: :foundation_profile
  # get 'foundations/:id' => 'foundations#show', as: :show

  resources :user_pictures
  post 'user_pictures/update' => 'user_pictures#update', as: :update

  resources :contacts, only: [:new, :create]

  # get 'welcome/index'
  # get 'email_messages/new' => 'email_messages#new', as: :new_email_messages
  #post 'events/create'=> 'events#create'
  #get 'events/:id' => 'events#show', as: :event
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks", :sessions => "users/sessions" }
  devise_scope :user do
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
    # post 'registrations/update_settings' => 'registrations#update_settings'
    post 'registrations/update' => 'registrations#update'
    post 'registrations/update_password' => 'registrations#update_password'
    get 'registrations/view_user_foundations' => 'registrations#view_user_foundations', as: :user_foundations
    get 'registrations/view_gigs_users' => 'registrations#view_gigs_users', as: :view_gigs_users
    get 'registrations/share_event' => 'registrations#share_event' , as: :share_event
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'events#index'
  # get 'events/join_volunteer'=> 'events#join_volunteer', as: :join_volunteer
  post 'join_new_event' => 'registrations#join_new_event', as: :join_new_event
  post 'join_event', :to => 'events#join_event'
  get 'events/join_event' => 'events#join_event'
  # get 'foundations/:id/support_foundation' => 'foundations#support_foundation', as: :support_foundation
  get 'foundations/:id/support_foundation', :to => 'foundations#support_foundation', as: :support_foundation
  # match 'foundations/:id/edit' => 'foundations#edit', via: [:get, :post]
  # match 'support_foundation' => 'foundations#support_foundation', as: :support_foundation, :via => [:get, :post]
  # get 'join_volunteer' => 'events#join_volunteer', as: :join_volunteer
  # get 'disjoin_volunteer' => 'events#disjoin_volunteer', as: :disjoin_volunteer
  post 'accept_friend_request' => 'friendships#accept_friend_request', as: :accept_friend_request
  post 'deny_friend_request' => 'friendships#deny_friend_request', as: :deny_friend_request
  get 'contacts/new', :to => 'contacts#new'
  # get 'inbox_notifications' => 'email_messages#index', as: :inbox_notifications
  match 'inbox_notifications' => 'email_messages#index', as: :inbox_notifications, :via => [:get, :post]
  post 'email_messages' => 'email_messages#email_message'
  post 'contact', :to => 'contacts#contact'
  get 'event_list', :to => 'events#event_list'
  post 'event_list', :to => 'events#event_list'
  post 'email_message_detail' => 'email_messages#email_message_detail', as: :email_message_detail
  post 'send_message_reply' => 'email_messages#send_message_reply', as: :send_message_reply
  post 'add_notification_message' => 'email_messages#add_notification_message', as: :add_notification_message
  get 'email_message_detail' => 'email_messages#email_message_detail'
  get 'friendsearch_request' => 'events#friendsearch_request'
  get 'search_users' => 'events#search_users'
  get 'glis_support' =>  'friendships#glis_support', as: :glis_support
  get 'users/:id' => 'friendships#user_profile', as: :user_profile

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
  match "*path", to: "welcome#catch_404", via: :all
end
