class UsersController < ApplicationController

    def new

    end

    def create
        @user = User.new(email: params[:email], login: params[:login], firstname: params[:firstname], lastname: params[:lastname], admin: false)
        if params[:password] = "admin"
            @user.admin = true
        end
        @user.encrypt_password(params[:password])
        if @user.save
            flash[:notice] = "You have succesfully registered!"
            current_user=(@user)
            session[:user_id] = @user.id
            if @user.admin
                redirect_to admin_task_lists_path
            else
                redirect_to root_path
            end
        else
            render :new
        end
    end

    def show
        
    end
end