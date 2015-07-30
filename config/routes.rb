Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get   '/client_token',  to: 'braintree#get_token'
      post  '/payment_nonce', to: 'braintree#payment_nonce'

      devise_scope :user do
        resources :users,       only: [:show, :update, :destroy]
        resources :menus,       only: [:index, :show, :update] do
          resources :orders, only: [:index, :show, :update], controller: 'menu_orders'
        end
        resources :orders,      only: [:index, :show, :create]
        post :users,      to: 'registrations#create'
        post :sessions,   to: 'sessions#create'
        delete :sessions, to: 'sessions#destroy'
      end
    end
  end

  devise_for :users
end
