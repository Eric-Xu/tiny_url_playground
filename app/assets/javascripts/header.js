$(function() {
	var menu = $('#nav_menu');
	var nav_links = $('nav ul');
	var break_point = 860; // check with media query

	$(menu).on('click', function(e) {
		e.preventDefault();
		nav_links.slideToggle();
	});

	$(window).resize(function(){
		var w = $(window).width();

		if (w > break_point && nav_links.is(':hidden')) {
			nav_links.removeAttr('style');
		} else if (w < break_point && nav_links.is(':visible')) {
			nav_links.hide();
		}
	});
});