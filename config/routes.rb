Rails.application.routes.draw do
  root to: 'covid#search'
  get '/search' => 'covid#search' 
end
