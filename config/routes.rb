Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create, :update, :show, :destroy]
      resources :movies, only: [:index, :create, :update, :show, :destroy] do
        post "add_actor", on: :member
        delete "remove_actor", on: :member

        post "add_director", on: :member
        delete "remove_director", on: :member

        post "add_producer", on: :member
        delete "remove_producer", on: :member
      end
    end
  end
end
