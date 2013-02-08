Boardwalk::Application.routes.draw do
  root to: 'boards#show'
  resources :boards

end
