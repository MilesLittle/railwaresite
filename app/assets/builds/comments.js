// app/javascript/comments.js
document.addEventListener("DOMContentLoaded", function() {
  const replyButtons = document.querySelectorAll(".reply-btn");
  replyButtons.forEach((button) => {
    button.addEventListener("click", function() {
      const commentId = this.getAttribute("data-comment-id");
      const replies = document.querySelector(`#comment_${commentId} .replies`);
      const replyForm = document.querySelector(`#comment_${commentId} .reply-form`);
      replies.style.display = replies.style.display === "none" ? "block" : "none";
      document.querySelectorAll(".reply-form").forEach((form) => {
        if (form !== replyForm) {
          form.style.display = "none";
        }
      });
      replyForm.style.display = replyForm.style.display === "none" ? "block" : "none";
    });
  });
});
//# sourceMappingURL=/assets/comments.js.map
