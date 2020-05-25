Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :moods, only: [:index, :new, :create]

  get '/moods/:date', to: 'moods#show', as: :date_moods
  get '/insights', to: 'moods#insights', as: :insights
end
