Rails.application.routes.draw do

  root to: 'homes#top'

  get 'roulette' => 'homes#roulette'

  devise_for :users, controllers: {
    :registrations => "users/registrations"
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :update, :edit, :index, :destroy] do
    resources :bookmarks, only: [:index]
  end

  resources :recipes do
    resource :bookmarks, only: [:create, :destroy]
    get 'recommend' => 'recipes#recommend'
  end
  get 'my_recipe' => 'recipes#my_recipe'
  get 'search'    => 'recipes#search'
  get 'my_search' => 'recipes#my_search'
  get 'bookmark_search' => 'bookmarks#bookmark_search'

  resources :menus

  resources :tags do
    get 'search' => 'recipes#tag_search'
  end

  resources :buy_items, only: [:index, :create, :update, :destroy]
  delete 'bought_destroy' => 'buy_items#bought_destroy'
  delete 'all_destroy' => 'buy_items#all_destroy'

end
