CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'tools' },
		{ name: 'clipboard',   groups: [ 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'links' },
		{ name: 'colors' },
		{ name: 'others' },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'align'] },
		{ name: 'insert'},
		{ name: 'styles' }
	];
	config.removeButtons = 'Underline,Subscript,Superscript';
	config.format_tags = 'p;h1;h2;h3;pre';
};
