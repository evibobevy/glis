Rails.application.routes.draw do

  post 'support' => 'friendships#support', as: :support
  post 'unsupport' => 'friendships#unsupport', as: :unsupport

  resources :posts do
    resources :comments
  end

  resources :events  do
    resources :posts
  end

  resources :volunteers

  resources :contacts, only: [:new, :create]

  # get 'welcome/index'
  # get 'email_messages/new' => 'email_messages#new', as: :new_email_messages
  #post 'events/create'=> 'events#create'
  #get 'events/:id' => 'events#show', as: :event
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'events#index'
  # get 'events/join_volunteer'=> 'events#join_volunteer', as: :join_volunteer
  get 'join_volunteer' => 'events#join_volunteer', as: :join_volunteer
  get 'disjoin_volunteer' => 'events#disjoin_volunteer', as: :disjoin_volunteer
  get 'accept_friend_request' => 'friendships#accept_friend_request', as: :accept_friend_request
  get 'deny_friend_request' => 'friendships#deny_friend_request', as: :deny_friend_request
  get 'contacts/new', :to => 'contacts#new'
  get 'email_messages' => 'email_messages#index', as: :email_messages
  post 'email_messages' => 'email_messages#email_message'
  post 'contact', :to => 'contacts#contact'
  get 'event_list', :to => 'events#event_list'
  post 'email_message_detail' => 'email_messages#email_message_detail', as: :email_message_detail
  post 'send_message_reply' => 'email_messages#send_message_reply', as: :send_message_reply
  get 'email_message_detail' => 'email_messages#email_message_detail'
  get 'friendsearch_request' => 'events#friendsearch_request'

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
