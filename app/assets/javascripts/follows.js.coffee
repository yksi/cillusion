$(document).on 'click', '.btn-follow', (e) ->
  $id = $(this).data("id")
  $num = parseInt($('.followers_counter').html())
  console.log($num)
  $.ajax({
    url: '/users/__' + $id + '/follow'
    type: 'post'
    dataType: 'json'})
    .done (data) ->
      console.log('success')
      $('.btn-follow').removeClass('btn-follow').addClass('btn-unfollow').html('<i class="fa fa-thumbs-down pull-left follows-icon"></i> Unfollow')
      jQuery.gritter.add({ image: '/assets/success.png', title: 'Success', text: 'Followed' + $('h2').text() });
      $('.followers_counter').html($num+1)

$(document).on 'click', '.btn-unfollow', (e) ->
  $id = $(this).data("id")
  $num = parseInt($('.followers_counter').html())
  console.log($id)
  $.ajax({
    url: '/users/__' + $id + '/unfollow'
    type: 'post'
    dataType: 'json'})
    .done (data) ->
      console.log('success')
      $('.followers_counter').html($num-1)
      $('.btn-unfollow').removeClass('btn-unfollow').addClass('btn-follow').html('<i class="fa fa-thumbs-up pull-left follows-icon"></i> Follow')
      $('.followers_counter').html($num-1)