Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get '/client_token', to: 'braintree#get_token'

      devise_scope :user do
        resources :users,       only: [:show, :update, :destroy]
        resources :menus,       only: [:index, :show, :update]
        resources :orders,      only: [:index, :show, :create]
        post :users,      to: 'registrations#create'
        post :sessions,   to: 'sessions#create'
        delete :sessions, to: 'sessions#destroy'
        get   "menus/:menu_id/orders",           to: 'menu_orders#index'
        get   "menus/:menu_id/orders/:order_id", to: 'menu_orders#show'
        patch "menus/:menu_id/orders/:order_id", to: 'menu_orders#update'
      end
    end
  end

  devise_for :users
end
