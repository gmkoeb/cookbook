Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show]
  resources :recipe_lists, only: %i[new create index] do
    get 'add_recipe', on: :member
    post 'add_recipe', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index]
    end
  end
end
