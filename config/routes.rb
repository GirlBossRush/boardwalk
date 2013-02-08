Boardwalk::Application.routes.draw do
  scope 'api' do
    resources :boards
  end

  root to: 'boards#index'
end
