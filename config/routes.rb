Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users, controllers: {
    :sessions => 'users/sessions'
  }

  resources :users, only: [:show, :update, :edit, :index] do
    resources :bookmarks, only: [:index]
    patch 'withdraw' => 'users#withdraw'
  end

  resources :recipes do
    resource :bookmarks, only: [:create, :destroy]
    get 'recommend' => 'recipes#recommend'
  end
  get 'my_recipe' => 'recipes#my_recipe'
  get 'search'    => 'recipes#search'

  resources :menus

  resources :tags do
    get 'search' => 'recipes#tag_search'
  end

end
