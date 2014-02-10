
$('#myTab a').click(function (e) {
  e.preventDefault()
  $('#myTab li:eq(0) a').tab('show')
  $('#myTab li:eq(1) a').tab('show')
 
})