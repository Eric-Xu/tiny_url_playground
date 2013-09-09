jQuery ->
	$('.definitions').removeClass('showing').addClass('hidden')
	$('.translate').removeClass('hidden').addClass('showing')

	$('.translate').click ->
		$definitions = $(this).prev('.definitions')
		$definitions.slideToggle 'slow', ->
			$definitions.toggleClass('hidden', $(this).is(':hidden'))
			$definitions.toggleClass('showing', $(this).is(':visible'))

		if $(this).text() == 'Translate'
			$(this).text('Hide')
		else
			$(this).text('Translate')