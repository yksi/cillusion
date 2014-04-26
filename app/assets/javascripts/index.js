$( document ).ready(function() {

  $('#file-input').change(function(e) {
    loadImage(
        e.target.files[0],
        function (img) {
          img.setAttribute("width", "100%");
          img.setAttribute("height", "auto%");
          $('#imagee').fadeIn().html(img);
        },
        {maxWidth: 300}
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

  $( "#close_notice" ).click(function() {
    d = document.getElementById("flash_info")
    d.className = "alert alert-info";
    $('#flash_info').addClass(' animated bounceOutLeft')
    d.innerHTML = ""
  });

  $( "#close_alert" ).click(function() {
    d = document.getElementById("flash_warning")
    d.className = "alert alert-warning";
    $('#flash_warning').addClass(' animated bounceOutLeft')
    d.innerHTML = ""
  });

  $("[data-toggle=popover]").popover({html:true})

  $('#example').click(function() {
    $('#example').popover();
  });

  $(".btn-follow").click(function() {
    $(".btn-follow").html('Following...')
  })

  $('[data-toggle="tooltip"]').tooltip()

});

