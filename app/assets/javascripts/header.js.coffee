jQuery ->
	$menu = $('#nav_menu')
	$navLinks = $('nav ul')

	# this is a coffeescript comment
	# check break_point in media query
	breakPoint = 684

	$menu.click (e) ->
		e.preventDefault()
		$navLinks.slideToggle 'slow', ->
			$navLinks.toggleClass('hidden', $(this).is(':hidden'))
			$navLinks.toggleClass('showing', $(this).is(':visible'))

	$(window).resize ->
		w = $(window).width()

		if w > breakPoint && $navLinks.is(':hidden')
			$navLinks.removeAttr('style').removeClass('hidden').addClass('showing')
		else if w < breakPoint && $navLinks.is(':visible')
			$navLinks.removeClass('showing').addClass('hidden')