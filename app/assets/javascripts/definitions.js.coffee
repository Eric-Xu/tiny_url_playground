jQuery ->
	$('.definitions').hide()
	$('.translate').css('display', 'block')

	$('.translate').click ->
		$(this).prev('.definitions').slideToggle()
		if $(this).text() == 'Translate'
			$(this).text('Hide')
		else
			$(this).text('Translate')