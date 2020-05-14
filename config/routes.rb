Rails.application.routes.draw do
  root to: 'covid#index'
  get '/search' => 'covid#search' 
end
