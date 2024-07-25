# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :load_sidebar_posts

  private

  def load_sidebar_posts
    @posts = Post.where(hidden: false ).order(created_at: :desc).limit(10) # Example: Load the 5 most recent posts
  end
  

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
      nil
    end

    
  end
  