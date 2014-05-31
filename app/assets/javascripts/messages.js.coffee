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

