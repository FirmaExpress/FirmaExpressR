FirmaExpressR::Application.routes.draw do
  devise_for :users#, controllers: { registrations:'devise/custom/registrations' }
  devise_scope :user do 
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
  root 'home#homepage'
  get "home" => "documents#new", as: 'user_root' #"new_document"
  get "show" => "documents#show", :as => "show_document"
  get "documents/new"
  get "sessions/new"
  get "users/new"
  get "users/rut", to: "users#rut"
  get "users/invite", to: "users#invite", as: "invite"
  get "/contact", to: "home#contact", as: "contact_form"
  post "users/contact", to: "users#contact", as: "contact"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "/register" => "users#new", :as => "sign_up"
  get "documents/sign/:id", to: "documents#sign"
  get "documents/destroy/:id", to: "documents#destroy"
  get "participants/:user_id/destroy/:document_id", to: "participants#destroy"
  get "documents/list", to: "documents#list"
  get "check_document/:id", to: "documents#check"
  get "/profile", to: "users#profile", as:"profile"
  get "users/update_profile", to: "users#update_profile", as:"update_profile"
  get "users/complete_invitee_profile", to: "users#complete_invitee_profile"
  post "users/complete_invitee_profile", to: "users#complete_invitee_profile"
  post "users/sign_image", to: "users#sign_image"
  default_url_options :host => "Firmaexpress.dev"
  resources :sessions
  resources :documents
  resources :users
  resources :subscriptions
  get 'paypal/checkout', to: 'subscriptions#paypal_checkout'
  # You can have the root of your site routed with "root"
  #get "/login", to: "home#login" 
  get "/about_us", to: "home#aboutus"
  get "/plans", to: "home#plans"
  get "/benefits", to: "home#benefits"
  get "/terms", to: "home#terms"
  get "/get_plan/:plan_id", to: "home#get_plan"
  post "/get_plan_post", to: "home#get_plan_post"
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :users, only: [:index, :show] do
      resources :documents, only: [:index, :show] do
        resources :signs, only: [:index, :create]
      end
    end
    #resources :documents, only: [:index, :show]
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
