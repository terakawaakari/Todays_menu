Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users

  resources :users, only: [:show, :update]
  get 'users/withdraw_confirm' => 'users#withdraw_confirm', as: 'withdraw_confirm'
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'

  resources :recipes
  get 'my_recipe' => 'recipes#my_recipe'
  get 'recommend' => 'recipes#recommend'

  resources :menus

  resources :tags do
    get 'search' => 'recipes#tag_search'
  end

end
