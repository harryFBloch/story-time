
function getCommentsForPost(post){
  fetchGetHelper(`/posts/${post.id}/comments`, jsonComments => {
      post.comments = jsonComments
      post.loadPostToDom()
  })
}

function laodPostCommentsToDom(comments){
  clearChildren('comments-reset')
  comments.forEach(comment => appendComment(comment))
}

function appendComment(comment){
  $('#comments-reset').append(`<hr /><li class = "collection_item s6 center">${comment.content} - posted by: ${comment.user.username}</li>`)
}

function submitComment(){
  event.preventDefault();
  body = {comment:{content: $('#comment_content')[0].value, post_id: $('h1')[0].dataset.id}}
  ajaxPostHelper('/comments', body, comment => {
    appendComment(comment)
  })
  return false
}
