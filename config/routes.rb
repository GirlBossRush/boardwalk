Boardwalk::Application.routes.draw do
  scope 'api' do
    resources :boards
    resources :users do
      resources :widgets
    end
    get 'search/:username', to: 'users#search', as: 'search'
    get 'check/:username', to: 'users#check', as: 'check'
    resources :sessions
  end

  root to: 'pages#index'
  match '*path', to: 'pages#index'
end
