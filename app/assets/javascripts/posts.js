class Post{
  constructor(attributes){
    this.id = attributes.id
    this.title = attributes.title
    this.image_url = attributes.image_url
    this.userId = attributes.user.id
    this.genre = attributes.genre.name
    this.sentances = []
    this.comments = []
  }

  getCommentsForPost(){
    fetch(`/posts/${this.id}/comments`,{
      method: "GET",
      headers:{
        contentType: 'application/json; charset=utf-8',
      }
    }).then(resp => resp.json().then(jsonComments => {
        this.comments = jsonComments
        this.loadPostToDom()
    }))
  }
  loadPostToDom(){
    loadPostAttributes(this)
    laodPostCommentsToDom(this.comments)
    this.getSentancesForPost()
  }

  getSentancesForPost(){
    fetch(`/posts/${this.id}/sentances`,{
      method: "GET",
      headers:{
        contentType: 'application/json; charset=utf-8',
      }
    }).then(resp => resp.json().then(jsonSentances => {
        this.sentances = jsonSentances
        loadSentancesToDom(this)
    }))
  }
}


function loadSentancesToDom(post){
  sentanceHash = post.sentances
  document.getElementById('sentance').innerHTML = sentanceHash.content
  if (sentanceHash.can_post === true) {
    allowPosting(post)
  }else{
    dontAllowPosting()
  }
}

function allowPosting(post){
  clearChildren('sentance-error')
  document.getElementById('sentance-error').innerHTML= createSentanceForm(post.id)
}

function createSentanceForm(id){
  return `
    <form class: "col s12">
    <div class="row">
        <div class="input-field col s6">
          <input type="hidden" value='${id}'>
          <input placeholder="Placeholder" id="sentance_content" type="text" name="sentance[content]">
          <label for="sentance-input">Add a Sentance</label>
        </div>
        <button class="btn waves-effect waves-light s6 orange darken-4" type="submit" name="action" onclick="submitSentanceForPost()">Submit Sentance
          <i class="material-icons right">send</i>
        </button>
      </div>
    </form>
  `
}

function dontAllowPosting(){
  clearChildren('sentance-form')
  document.getElementById('sentance-error').innerHTML = '<h5>Wait for someone else to post a sentance before you can add! share this post to get the story moving</h5>'
}

function loadPostAttributes(post){
  $("h1")[0].innerHTML = post.title
  $("h1")[0].dataset.id = post.id
  $("#genre")[0].innerText = post.genre
  $('#post-image')[0].src = post.image_url
}

function laodPostCommentsToDom(comments){
  clearChildren('comments-reset')
  comments.forEach(comment => appendComment(comment))
}

function clearChildren(id){
    document.getElementById(id).innerHTML = ''
}

function getPost(post_id){
  fetch(`/posts/${post_id}`,{
    method: "GET",
    headers:{
      contentType: 'application/json; charset=utf-8',
    }
  }).then(resp => resp.json().then(jsonPost => {
      const post = new Post(jsonPost)
      post.getCommentsForPost()

  }))
  return false
}

function appendComment(comment){
  $('#comments-collection').append(`<hr /><li class = "collection_item s6 center">${comment.content} - posted by: ${comment.user.username}</li>`)
}


function submitComment(){
  event.preventDefault();
  $.ajax('/comments',{
    method: "POST",
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify({comment:{content: $('#comment_content')[0].value, post_id: $('h1')[0].dataset.id}}),
    headers: {'X-CSRF-Token': Rails.csrfToken()}
  }).then(comment => {
    appendComment(comment)
  }).fail(error => console.log(error))
  return false
}

function submitSentanceForPost(){
  event.preventDefault();
  $.ajax('/sentances',{
    method: "POST",
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify({sentance:{content: $('#sentance_content')[0].value, post_id: $('h1')[0].dataset.id}}),
    headers: {'X-CSRF-Token': Rails.csrfToken()}
  }).then(sentance => {
    document.getElementById('sentance').append(sentance.content)
    dontAllowPosting()
  }).fail(error => console.log(error))
  return false
}

function nextPrevPost(next_bool){
  fetch(`/posts/${$('h1')[0].dataset.id}/next/?next_bool=${JSON.stringify(next_bool)}`,{
    method: "GET",
    headers:{
      contentType: 'application/json; charset=utf-8',
    }
  }).then(resp => resp.json().then(jsonPost => {
    const post = new Post(jsonPost)
    post.getCommentsForPost()
  }))
}
