jQuery ->
	if not Modernizr.input.autofocus
		$('.autofocus_input').trigger 'focus'