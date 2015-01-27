Illusion::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  get "browse/timeline"
  get "browse/users"
  get "browse/articles"
  get 'browse/groups'
  get "articles/search"
  root to: "users#index"
  get 'users/followers'
  get 'users/followed'
  get 'users/unique'
  get 'users/cover'
  get 'api/get_user'
  get 'api/get_user_avatar'
  get 'api/get_my_articles'
  get 'api/get_article_image'
  get 'api/get_followers'
  get 'api/get_all_users'
  get 'api/get_user_articles'
  get 'api/get_fullname'
  get 'api/get_article_comments'

  resources :dashboard

  scope controller: :terms, path: 'lead' ,only: [] do
    get :eula
  end

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:show, :index], shallow: true

  resources :articles
  resources :follows, only: [:create, :destroy]
  resources :comments
  resources :groups, path_names: { root: 'my' }


  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users do
    member do
      match :follow, via: [:get, :post]
      match :unfollow, via: [:get, :post]
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :messages

  resources :messages, only: [] do
    scope controller: :messages do
      member do
        match :mark_as_read, via: [:get, :post]
      end
    end
  end

  resources :articles, only: [] do
    scope controller: :articles do
      member do
        match :share_via_message, via: [:get, :post]
      end
    end
  end

  resources :groups do
    scope controller: :groups do
      member do
        match :add_article_to, via: [:get, :post]
        match :delete_article_from, via: [:get, :post]
      end
    end
  end
end
