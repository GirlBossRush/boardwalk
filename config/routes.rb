Boardwalk::Application.routes.draw do

  resources :sessions
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  scope 'api' do
    resources :boards
    resources :users
    get 'check/:username', to: 'users#check', as: 'check'
  end

  root to: 'pages#index'
  match '*path', to: 'pages#index'
end
