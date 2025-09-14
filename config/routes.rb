Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    # root 'posts#index'
    root "home#index"
    devise_for :users, :controllers => { registrations: 'registrations', confirmations: 'confirmations' }

    resources :users do
      member do
        get :following, :followers, :upload_avatar
      end
      collection do
        get :search
      end
    end

    resources :posts do
      resources :comments
      member do
        post :like, xhr: true
        post :unlike, xhr: true
      end
    end

    resources :relationships, only: [:create, :destroy]
    resources :zodiacs, only: :index do
      collection do
        get :find_name
      end
    end
  
    resources :zodiac_suits, only: :index
    resources :user_managements, only: :index
    resources :event_tracks, only: :index
    # resources :links
    resources :famous_people, only: [:index, :new, :create]
    # get '/:id', to: 'links#show'

    resources :polls, only: [:index, :show, :new, :create, :edit, :update] do
      resources :votes, only: [:create, :destroy]
      member do
        patch :toggle_visibility
      end
    end
  end
end
