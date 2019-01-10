class TasksController < ApplicationController
	skip_before_action :verify_authenticity_token
    before_action :login_required
    before_action :is_creator

	def status
		@task = Task.find(params[:task_id])
		if params[:status] != nil
			@task.update(status: 20)
		else
			@task.update(status: 10)
		end
	end

    def move_up
        @task = Task.find(params[:task_id])
        @task.move_higher
        redirect_to task_list_path(params[:task_list_id])
    end

    def move_down
        @task = Task.find(params[:task_id])
        @task.move_lower
        redirect_to task_list_path(params[:task_list_id])
    end

	def destroy
	    @task = Task.find(params[:id])
	    @task.destroy
	    respond_to do |format|
            format.js
	    end
	end

	def create
		@list = TaskList.find(params[:task_list_id])

		@task = @list.tasks.new(task_params)
		if @task.save
			flash[:notice] = "Your task has been added to list."
		else
			flash[:error] = "Your task has failing parameters. Please fix it"
		end
		redirect_to task_list_path(@list.id)
	end

	def update
		@list = TaskList.find(params[:task_list_id])
		@task = Task.find(params[:id])
		@task.name = params[:task][:name]
		if @task.save
			flash[:notice] = "Task updated!"
			redirect_to task_list_path(@list.id)
		else
			flash[:error] = @task.errors.full_messages
			render 'task_lists/show'
		end
	end


  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def is_creator
      if TaskList.find(params[:task_list_id]).user_id != current_user.id && current_user.admin == false
        flash[:error] = "You do not have permission to change other users' tasks."
        redirect_to task_list_path(params[:task_list_id])
      end
  end



end