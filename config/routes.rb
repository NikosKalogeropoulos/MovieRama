Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "movies#index"
  # add show for link of the user
  resources :users, only: [:create, :new]  do
     resources :movies, only: [:index]
  end


  resources :movies, only: [:create, :new, :index] do
    member do
      post :like, to: 'movies#like', as: 'like'
      post :hate, to: 'movies#hate', as: 'hate'
    end
  end

  resource :session, only: [:create, :new, :destroy]

end
