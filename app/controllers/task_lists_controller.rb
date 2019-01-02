class TaskListsController < ApplicationController


	def index 
		@tasklist = TaskList.new
	end

	def create
		binding.pry
		@list = TaskList.new()
	end




end