Rails.application.routes.draw do

	root to: 'admin/task_lists#index'

	resources :task_lists do 
		resources :tasks, only: [:create, :destroy, :update] do
			post :status
		end
	end


	:categories


	namespace :admin do
	  resources :task_lists, :tasks, :categories
	end













end
