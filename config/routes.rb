Boardwalk::Application.routes.draw do
  scope 'api' do
    resources :boards
  end

  root to: 'boards#index'
  match '*path', to: 'boards#index'
end
