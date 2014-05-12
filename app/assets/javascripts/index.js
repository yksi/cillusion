$( document ).ready(function() {

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

});

