jQuery ->
	menu = $('#nav_menu')
	nav_links = $('nav ul')

	# this is a coffeescript comment
	# check break_point in media query
	break_point = 684

	$(menu).click (e) ->
		e.preventDefault()
		nav_links.slideToggle()

	$(window).resize ->
		w = $(window).width()

		if w > break_point && nav_links.is(':hidden')
			nav_links.removeAttr('style')
		else if w < break_point && nav_links.is(':visible')
			nav_links.hide()