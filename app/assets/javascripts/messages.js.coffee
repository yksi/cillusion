$(document).on 'click', '.mark_as_read', (e) ->
  $id = $(this).data('id')
  $num = parseInt($(".new_messages").html())
  $.ajax({
    url: "/messages/" + $id + "/mark_as_read"
    type: "post"
    dataType: "json"})
    .done (data) ->
      $("span.new_alert."+$id).remove();
      if $num > 1
        $(".new_messages").html($num-1)
      else
        $(".new_messages").remove()

$(document).on 'click', '.share_via_message', () ->
  $id = $('#users_select').val()
  $article_id = window.location.pathname.split('/')[2]
  $.ajax({
    url: '/articles/' + $article_id + '/share_via_message',
    data: {
      user_id: $id
    },
    dataType: 'json'
  }).done ( data ) ->
    jQuery.gritter.add({ image: '/assets/success.png', title: 'Success', text: 'Successfully shared article'});
    $('#share_via_message').modal('hide')