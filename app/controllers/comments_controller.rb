class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create

    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    
      mentioned_usernames = @comment.body.scan(/@(\w+)/).flatten

      mentioned_usernames.each do |username|
        mentioned_user = User.find_by(username: username)
        next unless mentioned_user

        inbox = mentioned_user.inbox || Inbox.create(user:mentioned_user)
        @comment.inbox = inbox
      end

      if @comment.save
      redirect_to @post, notice: 'Comment created successfully.'
    else
      redirect_to @post, alert: 'Failed to create comment.'
    end
    
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    path_to_redirect = request.referer || root_path # Store the current path or redirect to root if unavailable

    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to path_to_redirect, notice: 'Comment deleted successfully.'
    else
      redirect_to path_to_redirect, alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def authenticate_user!
    redirect_to new_user_session_path, alert: 'Please sign in to perform this action' unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

 
end
