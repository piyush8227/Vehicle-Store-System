# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('homepage')
  get 'homepage', to: 'home#homepage'
  devise_for :users

  resources :vehicles do
    member do
      put :sold
    end
  end

  resources :manufacturers
end
