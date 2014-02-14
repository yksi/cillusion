$(function() {
	$("#dialog").dialog({
		autoOpen: false,
		width: 450,
		height: 325,
		modal: true, 
		resizable: false,
		open: function(event, ui) { $(".ui-dialog-titlebar-close").hide();}
	});
	$("#dialog_link").on("click", function(e) {
		e.preventDefault();
		$("#dialog").dialog("open");
	});
	$("#close_dialog").on("click", function(e) {
		e.preventDefault();
		$( "#dialog" ).dialog( "close" );
	});
});