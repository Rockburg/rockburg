Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :managers

  resources :bands do
    member do
      get :happenings
      get :songs
      get :recordings
      get :releases
      get :tours
      get :allmembers
    end
    resources :activities
    resources :songs
    resources :recordings

    resources :skills do
      resources :members do
        member do
          get 'hire'
        end
      end
    end
  end
  resources :managers
  resources :members
  resources :skills
  resources :charts do
    collection do
      get 'bands'
      get 'managers'
      get 'releases'
    end
  end


  get 'dashboard', to: 'managers#index', as: :dashboard

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#index"
end
