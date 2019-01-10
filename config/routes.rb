Rails.application.routes.draw do

	root to: 'task_lists#index'

	resources :task_lists do 
		resources :tasks, only: [:create, :destroy, :update] do
			post :status
            post :move_up
            post :move_down
		end
	end


	:categories

    resources :users, only: [:new,:show,:create,:edit,:update]

    get '/login', to: 'sessions#new'
    get '/logout', to: 'sessions#destroy'
    resources :sessions, only: :create

    namespace :admin do
      resources :task_lists
    end













end
