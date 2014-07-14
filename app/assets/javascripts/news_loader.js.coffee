seconds = 3

update_info = () ->
  $.ajax({
      url: '/messages.json',
      dataType: 'text'
    }).done (data) ->
      if data == '0'
        $('.new_messages').css('display', 'none')
      else
        $('.new_messages').css('display', 'inline').html(data)
  $.ajax({
    url: '/browse/timeline.json',
    dataType: 'text'
  }).done (data) ->
    if data == 'true'
      # alert(data)
      $('.new_logs').css('display', 'inline')
    else
      $('.new_logs').css('display', 'none')

$(document).on "page:change", () ->
  update_info()
  setInterval (->
    update_info()
  ), seconds * 1000