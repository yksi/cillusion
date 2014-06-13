$(document).on 'keyup', '#user_uid', (e) ->
  $.ajax({
    url: '/users/unique',
    data: { uid: $(this).val() },
    dataType: 'text'
  }).done (data) ->
    $('#username_message').html(data)
