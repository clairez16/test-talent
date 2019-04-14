function createCookie(key, value) {
    var cookie = escape(key) + "=" + escape(value) + ";";
    document.cookie = cookie;
}

function readCookie(name) {
  const key = name + "=";
  const cookies = document.cookie.split(';');
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

function random_item(items){
  return items[Math.floor(Math.random()*items.length)];
}

function loadColors(items){
  let count = 0
  document.querySelectorAll('.center-square').forEach(function(element){
    element.classList = 'center-square ' + items[count]
    count = count + 1
  })
}

function initializePage(){
  const colorClasses = ['bg-primary', 'bg-danger', 'bg-success', 'bg-warning']

  if (readCookie("startColors")) {
    var startColors = readCookie("startColors").split('%7C')
  } else {
    var startColors = []

    for(let i=0; i < 10; i++){
      startColors.push(random_item(colorClasses))
    }
    createCookie("startColors", startColors.join('|'));
  }

  loadColors(startColors)

  document.querySelectorAll('.corner-square').forEach(function(element) {
    element.addEventListener('click', function(event) {
      const current_color = event.currentTarget.classList[0]
      startColors.unshift(current_color)
      startColors.pop()
      loadColors(startColors)
      createCookie("startColors", startColors.join('|'));
    })
  })
}
