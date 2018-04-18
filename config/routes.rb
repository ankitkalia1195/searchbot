Rails.application.routes.draw do
  use_doorkeeper scope: 'api/v1/oauth'
  devise_for :users, only: [:sessions, :registrations], controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :search_tasks, only: [:index, :new, :create, :show]
  resources :search_results, only: :index

  root 'search_tasks#index'

  namespace :api do
    namespace :v1 do
      resources :links, only: :index
      resources :search_tasks, only: [:index, :create, :show]
      resources :search_results, only: :index
    end
  end
end
