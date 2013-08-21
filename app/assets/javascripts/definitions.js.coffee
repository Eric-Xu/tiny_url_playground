jQuery ->
	$('.definitions').hide()
	$('.translate').css('display', 'block')

	$('.translate').click ->
		$(this).prev('.definitions').slideToggle()