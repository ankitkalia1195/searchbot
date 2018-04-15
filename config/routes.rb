Rails.application.routes.draw do
  use_doorkeeper scope: 'api/v1/oauth'
  devise_for :users, only: [:sessions, :registrations], controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :search_tasks, only: [:index, :new, :create, :show]

  root 'search_tasks#index'

  namespace :api do
    namespace :v1 do
      resources :links, only: :index
    end
  end
end
