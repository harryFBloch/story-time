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
  loadPostToDom(){
    loadPostAttributes(this)
    laodPostCommentsToDom(this.comments)
    //api call to get sentances for posts
    fetchGetHelper(`/posts/${this.id}/sentances`,jsonSentances => {

        this.sentances = jsonSentances
        loadSentancesToDom(this)
    })
    this.checkCurrentUser()
  }
  //check current user to see if should show link for edit page
  checkCurrentUser(){
    fetchGetHelper('/current_user', user => {
      if (user.id === this.userId) {
        document.getElementById('edit-button').innerHTML = `<a href="/posts/${this.id}/edit" class = "orange-text darken-4">Edit Story</a>`
      }else{
        clearChildren('edit-button')
      }
    })
  }
}

//was not the last user to post
function allowPosting(post){
  clearChildren('sentance-form')
  clearChildren('sentance-error')
  document.getElementById('sentance-form').innerHTML= createSentanceForm(post.id)
}

//was the last user to post
function dontAllowPosting(){
  clearChildren('sentance-form')
  document.getElementById('sentance-error').innerHTML = '<h5 class = "col s6 offset-3 blue-grey darken-2">Wait for someone else to post a sentance before you can add! share this post to get the story moving</h5>'
}

function loadPostAttributes(post){
  $("h1")[0].innerHTML = post.title
  $("h1")[0].dataset.id = post.id
  $("#genre")[0].innerText = post.genre
  $('#post-image')[0].src = post.image_url
}

//search button on post index page
function searchButtonPressed(){
  event.preventDefault()
  var selector = document.getElementById("genre_id")
  var genre = selector.options[selector.selectedIndex].value
  fetchGetHelper(`/posts?search_string=${document.getElementById('search_string').value}&genre_id=${genre}`,postIndexCallback)
  return false
}

function postIndexCallback(jsonPosts){
  clearChildren("post-collection")
  let tempHTMLString = ""
  document.getElementById("length-posts").innerHTML = jsonPosts.length
  jsonPosts.forEach(post => {
    tempHTMLString += `<li class = "collection-item center"><a href="/posts/${post.id}">${post.title}</a> - ${post.genre.name} - By: ${post.user.username}</li>`
  })
  document.getElementById("post-collection").innerHTML = tempHTMLString
}

//if true next post if false prev post
function nextPrevPost(next_bool){
  fetch(`/posts/${$('h1')[0].dataset.id}/next/?next_bool=${JSON.stringify(next_bool)}`,{
    method: "GET",
    headers:{
      contentType: 'application/json; charset=utf-8',
    }
  }).then(resp => resp.json().then(jsonPost => {
    const post = new Post(jsonPost)
    // getCommentsForPost
    fetchGetHelper(`/posts/${post.id}/comments`, jsonComments => {
      post.comments = jsonComments
      post.loadPostToDom()
    })
  }))
}

function displayImage(input){
  document.getElementById('image-button').innerHTML = "Change Image"
  if (input.files && input.files[0]) {
    let reader = new FileReader()
    reader.onload = function (e) {
      $('#thumbnail')
        .attr('src', e.target.result)
    }
    reader.readAsDataURL(input.files[0])
  }
}
