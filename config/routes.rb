Rails.application.routes.draw do


default_url_options :host => "localhost:3030"
  get 'management', to: redirect('management/subscription')
  get 'management/subscription'

  post 'management/subscription', to: 'management#update_meal', as: 'management_update_meal'
  
  post 'management/update_payment_status', to: 'management#update_payment_status', as: 'management_update_payment_status'

  get 'management/edit_subscription/:id', to: 'management#edit_subscription', as: "management_edit_subscription"
  patch 'management/edit_subscription/:id', to: 'management#update_subscription'

  get 'management_edit_customer/:id', to: 'management#edit_customer', as: 'management_edit_customer'
  patch 'management_edit_customer/:id', to: 'management#update_customer'

  post 'general/payment', to: 'general#payment', as: 'payment'

  get 'general/subscription'

  get 'general/home'

  devise_for :customers, controllers: { sessions: "customers/sessions", registrations: 'customers/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'customers#show'

  resources :addresses, only: [:new, :edit, :update]

  resources :subscriptions, only: [:create, :edit, :update, :new] do
    member do
      get 'follow_a_friend'
    end
    collection do
      get 'ratings'
    end
  end
  
  get  'subscriptions/:id/payment',             to: 'subscriptions#payment',            as: 'edit_payment'
  post 'subscriptions/:id/update_area',         to: 'subscriptions#update_area'
  post 'subscriptions/:id/update_day_lunch',    to: 'subscriptions#update_day_lunch'
  post 'subscriptions/:id/update_day_dinner',   to: 'subscriptions#update_day_dinner'
  post 'subscriptions/:id/update_preferences',  to: 'subscriptions#update_preferences'
  get  'subscriptions/:id/quiz', to: 'subscriptions#preference_quiz', as: 'quiz'

  get 'customers/:id/edit_allergies', to: 'customers#edit_allergies', as: 'edit_allergies_customer'
  patch 'customers/:id/edit_allergies', to: 'customers#update_allergies', as: 'update_allergies_customer'
  namespace :management do
    resources :allergens
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
