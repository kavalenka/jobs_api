# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: [:create] do
    post :login, on: :collection
  end

  resources :jobs, only: [:create]
end
