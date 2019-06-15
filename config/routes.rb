Rails.application.routes.draw do
  root 'game#index'
  resources :square
  resources :game
end
