$(document).on("page:change", function() {

  $('#file-input').change(function(e) {
    loadImage(
      e.target.files[0],
      function (img) {
        img.setAttribute("width", "100%");
        img.setAttribute("height", "auto%");
        $('#imagee').fadeIn().html(img);
      },
      { maxWidth: 300 }
    );
  });

  $( "#target" ).click(function() {
    document.getElementById("divq").className = "";
    $('#divq').addClass(' animated bounceOutLeft')
  });

  $('.scrart').click(function() {
    $('html, body').animate({
        scrollTop: $(".user_articles").offset().top
    }, 500);
  });

  $('#modal-login').on('hidden.bs.modal', function () {
    document.getElementById("divq").className = "";
    $('#divq').addClass(' animated bounceInRight')
  });

  $("[data-toggle=popover]").popover( { html:true } )

  $('#example').click(function() {
    $('#example').popover();
  });

  $('[data-toggle="tooltip"]').tooltip()

  $('.paste_html_button').click(function() {
    $add_to_end = $('#paste_html :checkbox:checked').length > 0
    if($add_to_end) {
      CKEDITOR.instances.editor.setData(CKEDITOR.instances.editor.getData() + $('.paste_html').val())
    }
    else {
      CKEDITOR.instances.editor.setData($('.paste_html').val())
    }
    $('#paste_html').modal('toggle')
    $('.paste_html').val(null)
    console.log($add_to_end)
  })

  $('.hide-side').click(function(e) {
    console.log($(this).data())
    if($(this).data('show') == true) {
      $(this).data('show', false)
      $('.col-xs-6').css('display', 'none')
      $('.col-md-8').removeClass('col-md-8').addClass('col-md-12')
      $(this).html('<i class="fa fa-arrow-left"></i>')
    }
    else {
       $(this).data('show', true)
      $('.col-xs-6').css('display', 'block')
      $('.col-md-12').removeClass('col-md-12').addClass('col-md-8')
      $(this).html('<i class="fa fa-arrow-right"></i>')
    }

  })

  $('.navbar-collapse').on('show.bs.collapse', function () {
    $('.browse-btn').removeClass('rounded-btn').addClass('pander').html($('.browse-btn').html() + '| Browse')
    $('.timeline-btn').removeClass('rounded-btn').addClass('pander').html($('.timeline-btn').html() + '| Timeline')
    $('.messages-btn').removeClass('rounded-btn').addClass('pander').html($('.messages-btn').html() + '| Messages')
    $('.groups-btn').removeClass('rounded-btn').addClass('pander').html($('.groups-btn').html() + '| Groups')
    $('.new_article-btn').removeClass('rounded-btn').html($('.new_article-btn').html() + '| Create new article').css('padding', '20px')
    $('.navbar-search').css('display', 'none')
    $('.nav-btn').removeClass('nav-btn').addClass('nav-btn-removed')
  })

  $('.navbar-collapse').on('hide.bs.collapse', function () {
    $('.browse-btn').addClass('rounded-btn').removeClass('pander').html($('.browse-btn').html().split('|')[0])
    $('.timeline-btn').addClass('rounded-btn').removeClass('pander').html($('.timeline-btn').html().split('|')[0])
    $('.messages-btn').addClass('rounded-btn').removeClass('pander').html($('.messages-btn').html().split('|')[0])
    $('.groups-btn').addClass('rounded-btn').removeClass('pander').html($('.groups-btn').html().split('|')[0])
    $('.new_article-btn').addClass('rounded-btn').html($('.new_article-btn').html().split('|')[0]).css('padding', '')

    $('.navbar-search').css('display', 'inline')
    $('.nav-btn').addClass('nav-btn').removeClass('nav-btn-removed')
  })

  $( window ).resize(function() {
    if($('.navbar-collapse.in').css('display') == 'block')$('.navbar-collapse').collapse('toggle')
  })

  $('#articles_select').select2({
    placeholder: "Select an Article",
    allowClear: true
  });

  $('#message_recipient_id').select2({
    placeholder: "Select an Article",
    allowClear: true
  });

  $('.btn-hide-right-pane').click(function() {
    if($('.right-pane').width() > 0){
      $('.right-pane').css('width', '0px')
      $(this).css('position', 'fixed').css('right', '10px').css('width', '100px')
    } else {
      $('.right-pane').css('width', '300px')
    $(this).css('position', 'static').css('width', '300px')
    }
  })
});

