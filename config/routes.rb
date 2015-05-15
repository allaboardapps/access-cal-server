Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root to: "static#home"
end
