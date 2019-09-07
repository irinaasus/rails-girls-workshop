Rails.application.routes.draw do
  resources :goals

  get 'about', to: 'static_pages#about'
  get 'static_pages/about'

  root to: 'static_pages#about'
end
