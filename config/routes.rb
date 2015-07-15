Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      devise_scope :user do
        post :users,  to: 'registrations#create'
      end
    end
  end

  devise_for :users
end
