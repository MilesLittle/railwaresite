// app/assets/javascripts/comments.js

function confirmDeletion(commentId) {
    $.ajax({
      url: '/comments/' + commentId,
      method: 'DELETE',
      dataType: 'script'
    });
  }
  // app/assets/javascripts/comments.js

function showConfirmButton(commentId) {
    $('#confirmBtn_' + commentId).show();
  }
  
  // comments.js

document.addEventListener('DOMContentLoaded', function() {
  const replyButtons = document.querySelectorAll('.reply-btn');

  replyButtons.forEach(button => {
    button.addEventListener('click', function() {
      const commentId = this.getAttribute('data-comment-id');
      const replies = document.querySelector(`#comment_${commentId} .replies`);
      const replyForm = document.querySelector(`#comment_${commentId} .reply-form`);

      // Toggle visibility of replies
      replies.style.display = replies.style.display === 'none' ? 'block' : 'none';

      // Hide other reply forms
      document.querySelectorAll('.reply-form').forEach(form => {
        if (form !== replyForm) {
          form.style.display = 'none';
        }
      });

      // Toggle visibility of reply form
      replyForm.style.display = replyForm.style.display === 'none' ? 'block' : 'none';
    });
  });
});
