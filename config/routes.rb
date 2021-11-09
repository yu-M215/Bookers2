Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followeds' => "relationships#followeds", as: "followeds"
    get 'followers' => "relationships#followers", as: "followers"
  end

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/search' => 'searches#search', as: "search"
  get '/message/:id' => 'messages#show', as: "message"

  resources :messages, only: :create
end
