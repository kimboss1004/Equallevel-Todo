class SessionsController < ApplicationController

    def new
        
    end

    def create
        @user = User.authenticate(params[:login], params[:password])
        if @user != nil
            current_user= @user
            session[:user_id] = @user.id
            flash[:notice] = "You have succesfully logged in!"
            if @user.admin
                redirect_to admin_task_lists_path
            else
                redirect_to root_path
            end
        else
            flash[:error] = "Incorrect Login. Try Again."
            redirect_to login_path
        end
    end

    def destroy
        current_user= nil
        session[:user_id] = nil
        flash[:notice] = "You have logged out."
        redirect_to login_path
    end



end