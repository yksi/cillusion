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
    document.getElementById("flash_info").className = "alert alert-info";
    $('#flash_info').addClass(' animated bounceOutLeft')
  });

  $( "#close_alert" ).click(function() {
    document.getElementById("flash_warning").className = "alert alert-warning";
    $('#flash_warning').addClass(' animated bounceOutLeft')
  });

});

