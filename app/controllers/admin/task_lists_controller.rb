class Admin::TaskListsController < ApplicationController

	def index
		query = "#{(params[:query] || "").downcase}%"
		if TaskList.all == []
			a = TaskList.new(name: "list 1 Cooking Recipes")
			b = TaskList.new(name: "list 2 Art of Shaving")
			c = TaskList.new(name: "list 3 Skiing Essentials")
			@task_lists = [a,b,c]
			if params[:query] 
				@task_lists = TaskList.where(name: params[:query])
				params[:query] = nil
			end
			sort = (params[:sort] || "name") + " " + (params[:dir] || "asc")
		else
			if params[:query] 
				@task_lists = TaskList.where(name: params[:query])
				params[:query] = nil
			elsif params[:dir] != nil
				if params[:dir] == "desc"
					@task_lists = TaskList.order("name DESC")
				else
					@task_lists = TaskList.order("name ASC")
				end
			else
				@task_lists = TaskList.all
			end
		end

	end

	def show
		@list = TaskList.find(params[:id])
		@tasks = @list.tasks
	end

	def new
		@task_list = TaskList.new
		10.times { @task_list.tasks.build }
		@categories = Category.all
		@task_list.categories << Category.new
	end

	def create
		@task_list = TaskList.new(name: params[:task_list][:name], user_id: 1)
		params[:task_list][:category_ids].each do |string_id|
			if string_id != ""
				@task_list.categories << Category.find(string_id.to_i)
			end
		end
		if @task_list.save
			params[:task_list][:tasks_attributes].values.each do |task_param|
				if task_param[:name] != ""
					@task_list.tasks.create(task_param)
				end
			end
			redirect_to root_path
		else
		  render :new
		end
	end




end














