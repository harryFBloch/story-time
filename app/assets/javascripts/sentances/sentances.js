function submitSentanceForPost(){
  event.preventDefault();
  body = {sentance:{content: $('#sentance_content')[0].value, post_id: $('h1')[0].dataset.id}}
  ajaxPostHelper('/sentances',body, sentance => {
    document.getElementById('sentance').append(sentance.content)
    dontAllowPosting()
  })
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

function createSentanceForm(id){
  return `
    <form >
        <div class="input-field col s4">
          <input type="hidden" value='${id}' name="post_id">
          <input id="sentance_content" type="text" name="sentance[content]">
          <label for="sentance_content">Add a Sentance</label>
          <button class="btn waves-effect waves-light orange darken-4" type="submit" name="action" onclick="submitSentanceForPost()">Add Sentance
          </button>
        </div>
    </form>
  `
}
