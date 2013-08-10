jQuery ->
	menu = $('#nav_menu')
	nav_links = $('nav ul')

	# this is a coffeescript comment
	# check break_point in media query
	break_point = 860

	$(menu).on 'click', (e) ->
		e.preventDefault()
		nav_links.slideToggle()

	$(window).resize ->
		w = $(window).width()

		if w > break_point && nav_links.is(':hidden')
			nav_links.removeAttr('style')
		else if w < break_point && nav_links.is(':visible')
			nav_links.hide()

# // $(function() {
# // 	var menu = $('#nav_menu');
# // 	var nav_links = $('nav ul');
# // check break_point in media query
# // 	var break_point = 860;

# // 	$(menu).on('click', function(e) {
# // 		e.preventDefault();
# // 		nav_links.slideToggle();
# // 	});

# // 	$(window).resize(function(){
# // 		var w = $(window).width();

# // 		if (w > break_point && nav_links.is(':hidden')) {
# // 			nav_links.removeAttr('style');
# // 		} else if (w < break_point && nav_links.is(':visible')) {
# // 			nav_links.hide();
# // 		}
# // 	});
# // });