class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_back_or_default(root_path)
    else
      flash.now[:alert] = 'Username or password is incorrect'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  private

  def redirect_back_or_default(default)
    redirect_to(session[:previous_url] || default)
    session[:previous_url] = nil
  end
end

