Rails.application.routes.draw do
  devise_for :users
  root to: 'moods#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :moods, only: [:index, :new, :create]

  get '/moods/calendar', to: 'moods#calendar', as: :calendar_moods
  get '/moods/habits', to: 'moods#habits', as: :habit_moods
  get '/moods/:date', to: 'moods#show', as: :date_moods
  get '/insights', to: 'moods#insights', as: :insights
  get '/moods/new/smiley', to: 'moods#new_smiley', as: :new_smiley_mood
end
