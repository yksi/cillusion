Illusion::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get "browse/index"
  get "browse/timeline"
  get "articles/search"
  root "users#index"
  get "users/index"
  get "comments/show"

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, :only => [:index, :show]
  resources :articles
  resources :follows, only: [:create, :destroy]
  resources :comments

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :messages

  resources :messages do
    scope controller: :messages do
      member do
        match :mark_as_read, via: [:get, :post]
      end
    end
  end
end
