Rails.application.routes.draw do
  resources :articles
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/p/:slug', to: 'articles#show_by_slug', as: 'post'
  # Defines the root path route ("/")
  root "articles#index"
end
