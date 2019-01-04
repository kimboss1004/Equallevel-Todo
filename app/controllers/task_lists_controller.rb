class TaskListsController < ApplicationController


	def index 
		@tasklist = TaskList.new
	end

	def show
		@list = TaskList.find(params[:id])
		@task = Task.new
	end


end