Rails.application.routes.draw do
  root 'game#index'
  resources :square
end
