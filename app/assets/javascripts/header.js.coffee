jQuery ->
	$menu = $('#nav_menu')
	$navLinks = $('nav ul')

	# this is a coffeescript comment
	# check break_point in media query
	breakPoint = 684

	$menu.click (e) ->
		e.preventDefault()
		$navLinks.slideToggle()

	$(window).resize ->
		w = $(window).width()

		if w > breakPoint && $navLinks.is(':hidden')
			$navLinks.removeAttr('style')
		else if w < breakPoint && $navLinks.is(':visible')
			$navLinks.hide()