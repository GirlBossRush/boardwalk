Boardwalk::Application.routes.draw do
  scope 'api' do
    resources :boards
    resources :users
    resources :sessions
    get 'check/:username', to: 'users#check', as: 'check'
  end

  root to: 'pages#index'
  match '*path', to: 'pages#index'
end
