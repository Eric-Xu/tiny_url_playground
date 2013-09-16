jQuery ->
	$('#back_to_top').click ->
		$('body, html').animate({scrollTop: 0}, 1000)
		return false

	$(window).scroll ->
		if $(window).scrollTop() > 300
			$('#back_to_top').fadeIn()
		else
			$('#back_to_top').fadeOut()