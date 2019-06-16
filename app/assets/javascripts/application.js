//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


function readCookie(name) {
  var key = name + "=";
  var cookies = document.cookie.split(';');
  for (var i = 0; i < cookies.length; i++) {
    var cookie = cookies[i];
    while (cookie.charAt(0) === ' ') {
            cookie = cookie.substring(1, cookie.length);
        }
    if (cookie.indexOf(key) === 0) {
            return cookie.substring(key.length, cookie.length);
        }
  }
  return null;
}

function checkGameStatus() {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");

  $.ajax({
    method: "GET",
    url: 'game/1',
    headers: { 'X-CSRF-Token': csrf },
    success: function(data) {
      $('.game-status').text(data.descriptive_status);
      setTimeout(checkGameStatus, 1000);
    }
  })
}

function playSquare(squareId) {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");

  $.ajax({
    method: "PUT",
    url: `square/${squareId}`,
    headers: { 'X-CSRF-Token': csrf },
    success: function(data, status) {
      checkGameStatus()

      if (data === 'Wait') {
        alert('Please wait for other player to play a tile.')
      }

      if (status === 'success' && readCookie('player') === "1" && data['player2_ship'] === true) {
        $(`#${data.id}`).addClass('hit');
      } else if (status === 'success' && readCookie('player') === "2" && data['player1_ship'] === true) {
        $(`#${data.id}`).addClass('hit');
      } else {
        $(`#${data.id}`).addClass('miss');
      }
    }
  })
}

window.onload = (event) => {
  setTimeout(checkGameStatus, 1000);
};