class TaskListsController < ApplicationController
    before_action :login_required #, only: [:create, :destroy]
    before_action :admin_redirect, only: [:index]

	def show
		@list = TaskList.find(params[:id])
		@task = Task.new
        if current_user.id != @list.user_id && current_user.admin == false 
            flash[:error] = "That is not your tasklist."
            redirect_to root_path
            return
        end
	end

    def index
        query = "#{(params[:query] || "").downcase}%"
        if logged_in?
            if params[:query] == "all"
                @task_lists = TaskList.order("name ASC")
            else
                @task_lists = TaskList.where(user_id: current_user.id).order("name ASC")
            end
        else
            @task_lists = TaskList.all.order("name ASC")
        end
    end

    def new
        @task_list = TaskList.new
        count = 0
        10.times { 
            count = count + 1
            @task_list.tasks.build(position: count) 
        }
        @categories = Category.all
        @task_list.categories << Category.new
    end

    def create
        # @task_list = TaskList.new(name: params[:task_list][:name], user_id: current_user.id)
        @task_list = TaskList.new(list_params.merge({user_id: current_user.id}))
        @task_list.category_ids = params[:task_list][:category_ids].reject(&:blank?)
        if @task_list.save
            flash[:notice] = "List was created"
            redirect_to root_path
        else
          render :new
        end
    end

    def destroy
        @task_list = TaskList.find(params[:id])
        if current_user.id != @task_list.user_id && current_user.admin == false
            flash[:error] = "That is not your tasklist. You do not have the permission."
            redirect_to root_path
            return
        end
        @task_list.destroy
        flash[:notice] = "List was deleted by admin"
        redirect_to admin_task_lists_path(@task_list.id)
    end


    private


    def admin_redirect
        if logged_in? && current_user.admin
            redirect_to admin_task_lists_path
        end
    end

    def list_params
        params[:task_list][:tasks_attributes].each do |key, values|
            if values[:name] == ""
                params[:task_list][:tasks_attributes].delete(key)
            end
        end
      params.require(:task_list).permit(:name, tasks_attributes: [ :name, :description, :position ])
    end



end