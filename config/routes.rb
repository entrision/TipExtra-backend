Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      devise_scope :user do
        resources :users, only: [:show, :update, :destroy]
        resources :menus, only: [:show, :index]
        resources :orders, only: [:index, :show, :create]
        post :users,      to: 'registrations#create'
        post :sessions,   to: 'sessions#create'
        delete :sessions, to: 'sessions#destroy'
      end
    end
  end

  devise_for :users
end
