Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"

  resources :profiles, only: [:show, :index, :edit, :update]

   # RESTful resources
   resources :posts do
    resource :like, only: [:create, :destroy]
    resources :post_interests, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    member do
      post 'like'
      delete 'unlike'
    end
    #   post 'share'
    #   delete 'unshare'
    # end
  end

  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :user_interests, only: [:create, :destroy]

  # User profiles and following functionality
  resources :users, only: [:index, :show] do
    member do
      post 'follow'
      delete 'unfollow'
    end

    # collection do
    #   get 'feed'  # For showing the user's personalized feed
    # end
  end

  resources :follows, only: [:index]

  resources :follows, only: [] do
    collection do
      get 'following'  # List of users you're following
      get 'followers'  # List of users who follow you
    end
  end

  # Interests
  resources :interests, only: [:index, :show] do
    member do
      post 'follow'    # For following an interest
      delete 'unfollow'  # For unfollowing an interest
    end
  end

  # Additional custom routes
  get 'explore', to: 'posts#explore'  # For discovering new content
  get 'trending', to: 'posts#trending'  # For trending posts
  get 'search', to: 'search#index'  # For search functionality


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
