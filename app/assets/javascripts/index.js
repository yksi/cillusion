$( document ).ready(function() {

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

});

