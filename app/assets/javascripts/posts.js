

function submitComment(){
  event.preventDefault();
  $.ajax('/comments',{
    method: "POST",
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify({comment:{content: $('#comment_content')[0].value, post_id: $('h1')[0].dataset.id}}),
    headers: {'X-CSRF-Token': Rails.csrfToken()}
  }).then(comment => {
    console.log(comment)
    $('#comments-collection').append(`<hr /><li class = "collection_item s6 center">${comment.content} - posted by: ${comment.user.username}</li>`)
  }).fail(error => console.log(error))
  return false
}
