$(document).on 'click', '.btn-follow', (e) ->
  $id = $(this).data("id")
  $(this).removeClass('animated flipInY')
  $num = parseInt($('.followers_counter').html())
  console.log($num)
  $.ajax({
    url: '/users/__' + $id + '/follow'
    type: 'post'
    dataType: 'json'})
    .done (data) ->
      console.log('success')
      jQuery.gritter.add({ image: '/assets/success.png', title: 'Success', text: 'Followed' + $('h2').text() });
      $('.btn-follow').addClass('animated flipInY').removeClass('btn-follow').addClass('btn-unfollow').html('<i class="fa fa-thumbs-down pull-left follows-icon"></i> Unfollow')
      $('.followers_counter').html($num+1)

$(document).on 'click', '.btn-unfollow', (e) ->
  $id = $(this).data("id")
  $(this).removeClass('animated flipInY')
  $num = parseInt($('.followers_counter').html())
  console.log($id)
  $.ajax({
    url: '/users/__' + $id + '/unfollow'
    type: 'post'
    dataType: 'json'})
    .done (data) ->
      console.log('success')
      $('.followers_counter').html($num-1)
      $('.btn-unfollow').addClass('animated flipInY').removeClass('btn-unfollow').addClass('btn-follow').html('<i class="fa fa-thumbs-up pull-left follows-icon"></i> Follow')