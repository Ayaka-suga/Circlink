Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  get 'homes', to: 'homes#index'
  resources :blogs 
  get 'tweets/:tweet_id/likes' => 'likes#create'
  get 'tweets/:tweet_id/likes/:id' => 'likes#destroy'

  get 'switch_group/:id', to: 'groups#switch', as: :switch_group

  resources :groups do
    resources :tweets
    resources :group_users, only: [:create]
  end
  
  resources :tweets do
    collection do 
      get :calendar 
    end
    resources :likes, only: [:create, :destroy]
    get 'tweets/attendance' => 'tweets#attendance'
  end
end