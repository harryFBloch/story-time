function fetchGetHelper(url,callback){
  fetch(url,{
    method: "GET",
    headers:{
      contentType: 'application/json; charset=utf-8',
    }
  }).then(resp => resp.json().then(callback))
}

function clearChildren(id){
    console.log(document.getElementById(id), id)
    document.getElementById(id).innerHTML = ''
}

function ajaxPostHelper(url, body, callback){
  $.ajax(url,{
    method: "POST",
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(body),
    headers: {'X-CSRF-Token': Rails.csrfToken()}
  }).then(callback).fail(error => console.log(error))
}
