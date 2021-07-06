Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users

  resources :users, only: [:show, :update] do
    resources :bookmarks, only: [:index]
  end
  get 'users/withdraw_confirm' => 'users#withdraw_confirm', as: 'withdraw_confirm'
  patch 'users/withdraw'       => 'users#withdraw',         as: 'withdraw'

  resources :recipes do
    resource :bookmarks, only: [:create, :destroy]
    get 'recommend' => 'recipes#recommend'
  end
  get 'my_recipe' => 'recipes#my_recipe'

  resources :menus

  resources :tags do
    get 'search' => 'recipes#tag_search'
  end

end
