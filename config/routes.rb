Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # add show for link of the user
  resources :users, only: [:create, :new, :show] 


  resources :movies

  resource :session, only: [:create, :new, :destroy]

end
