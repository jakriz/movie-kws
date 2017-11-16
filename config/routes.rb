Rails.application.routes.draw do
  resources :keywords, only: [:index, :show] do
    get 'autocomplete', on: :collection
  end
  match 'keywords/:id/:year' => 'keywords#show_year', as: :keyword_year, via: :get

  resources :movies, only: [:index]
  
  root to: 'movies#index'
end
