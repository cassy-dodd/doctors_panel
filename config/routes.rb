# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#create'
      resources :patients, only: %i[index update]
      namespace :doctors do
        resources :patients, only: :index
      end
    end
  end
end
