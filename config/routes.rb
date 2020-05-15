Rails.application.routes.draw do
  root to: 'covid#index_countries'
  get '/search' => 'covid#search'
  get '/countries' => 'covid#index_countries' 
end
