# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: [:create] do
    post :login, on: :collection
  end

  get "/auto_login", to: "users#auto_login"
end
