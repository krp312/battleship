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
      $('.game-status').text(data.status);

      if (data.status === 'player2_wins') {
        alert('Player 2 wins!');
      }

      if (data.status === 'player1_wins') {
        alert('Player 1 wins!');
      }
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
        alert('Please wait for other player to complete their turn');
      }

      if (status === 'success' && readCookie('player') === 'one' && data['player2_ship?'] === true) {
        $(`#${data.id}`).addClass('hit');
      } else if (status === 'success' && readCookie('player') === 'two' && data['player1_ship?'] === true) {
        $(`#${data.id}`).addClass('hit');
      } else {
        $(`#${data.id}`).addClass('miss');
      }
    }
  })
}

window.onload = (event) => {
  checkGameStatus();
};