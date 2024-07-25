module CommentsHelper
    def link_to_commenter(comment)
        if current_user == comment.user
          comment.user.username
        else
          link_to comment.user.username, show_other_user_path(comment.user)
        end
      end
end
