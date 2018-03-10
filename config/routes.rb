Rails.application.routes.draw do 
  resources :movies   
  root :to => redirect('/movies')
  #get '/sorttitle' => MoviesController, as: :sort_title
  #get :sort_title, on: :MoviesController
  
end
