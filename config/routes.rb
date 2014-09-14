Rails.application.routes.draw do
  get 'tasks/index'

  resources :tasks, except: [:new, :edit]

  match "*path", to: "tasks#index", via: "get"

  root 'tasks#index'
end
