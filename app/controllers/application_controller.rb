require 'pry'
require 'authenticated_system'

class ApplicationController < ActionController::Base

    SESSION_TTL = 60
    
    include AuthenticatedSystem
        
    before_action :check_session_expiration

    protected

        def check_session_expiration
            # Don't check the session expiration for the logout action
            return true if params[:controller] == 'sessions' && params[:action] == 'destroy'
            
            # If the user is logged in make sure their session hasn't expired
            if logged_in?
                if session.has_key?(:expires_at) && (Time.parse(session[:expires_at]) - Time.now).to_i <= 0
                    if session[:user_id] != nil # TODO: this needs to be changed
                        # If the guest user is authorized for the current action,
                        # we need to let the request go through without the session data
                        # This happens when a users session expires and they try to punchout
                        # to the application
                        destroy_session()
                        return true
                    else
                        # Session has expired
                        redirect_to(logout_path(:expired => 1))
                        return false
                    end
                else
                    # Extend the session expiration
                    ttl = SESSION_TTL.minutes
                    session[:expires_at] = ttl.from_now if params[:_extend_session] != '0' 
                end
            end
            return true
        end

        def destroy_session()
            cookies.delete :auth_token
            reset_session
        end



end
