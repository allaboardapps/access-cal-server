Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :user

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root to: "static#home"

  resources :calendars
  resources :events

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "sign_in" => "sessions#create"
      resources :calendars
      resources :calendar_users, only: [:create, :destroy]
      resources :events
      resources :event_users, only: [:create, :destroy]
      resources :favorites
      resources :locations
      resources :organizations
      resources :regions
      resources :users
    end
  end
end
