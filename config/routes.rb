Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    root 'posts#index'
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
    resources :zodiacs, only: [:index]
    resources :zodiac_suits, only: [:index]

    resources :user_managements, only: :index
  end
end
