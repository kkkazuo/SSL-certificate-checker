Rails.application.routes.draw do
  resources :notifications, only: %i(index)
  resources :checking_logs, only: %i(index)
  resources :domains, only: %i(index)
end
