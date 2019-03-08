Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
    match '/movies/:id/bydirector', to:'movies#bydirector', as: 'director_movie', via: :get
end
