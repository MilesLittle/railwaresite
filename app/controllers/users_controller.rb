class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @comments = @user.comments

    
    @inbox = @user.inbox

    if @inbox.present?
      @inbox_comments = @inbox.comments
    end

    if current_user && current_user.admin?
      @posts = @user.posts
    end
      
  end

  def show_other
    @other_user = User.find(params[:id])
    @comments = @other_user.comments
    @posts = @other_user.posts
    render 'show_other'
  end



  def create
    @user = User.new(user_params)
    if @user.save

      @user.create_inbox
      # Log in the user after successful registration
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User successfully registered!'
    else

      render :new, status: :unprocessable_entity
    end
  end
  

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
