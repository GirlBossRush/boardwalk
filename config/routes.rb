Boardwalk::Application.routes.draw do
  scope 'api' do
    resources :boards
  end

  root to: 'pages#index'
  match '*path', to: 'boards#index'
end
