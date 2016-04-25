Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :user

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount PgHero::Engine, at: "pghero"
  end

  root to: "static#home"

  resources :calendars
  resources :events

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "sign_in" => "sessions#create"
      resources :calendar_users, only: [:create, :destroy]
      resources :calendars
      resources :event_users, only: [:create, :destroy]
      resources :events
      resources :favorites
      resources :groups
      resources :group_users, only: [:create, :destroy]
      resources :locations
      resources :organizations
      resources :organization_users, only: [:create, :destroy]
      resources :regions
      resources :users
    end
  end
end
