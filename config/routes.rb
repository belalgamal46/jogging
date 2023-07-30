# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/users', to: 'users/users#index'
  put '/users/:id', to: 'users/users#update'
  patch '/users/:id', to: 'users/users#update'
  delete '/users/:id', to: 'users/users#destroy'


  namespace :api do
    namespace :v1 do
      resources :jogging_sessions
      get '/report/:period', to: 'jogging_sessions#report'
    end
  end

end
