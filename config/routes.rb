Rails.application.routes.draw do
  resources :articles
  devise_for :users, path: 'user',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',
                           confirmation: 'verification', unlock: 'unblock', registration: 'register',
                           sign_up: 'sign_up' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/p/:slug', to: 'articles#show_by_slug', as: 'post'
  # Defines the root path route ("/")
  root "articles#index"
end
