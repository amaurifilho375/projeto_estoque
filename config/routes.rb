Rails.application.routes.draw do
  resources :storages
  resources :products
  
  root 'movimentation#index'

  get 'movimentation/index'
  
  post '/movimentation/importar', to: 'movimentation#importar'
  get 'movimentation/importar'

  get '/movimentation/new'
  get '/movimentation/create_show'
   

# root 'movimentation#index'

end
