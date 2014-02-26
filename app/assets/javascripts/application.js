// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.effect-blind
//= require jquery.ui.effect-fade
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require fancybox
//= require turbolinks

//= require bootstrap-datepicker 

jQuery(function() {
  $('a.fancybox').fancybox();
});
jQuery(function() {
	$("#submitme").bind("submit", function() {

	$.fancybox.showActivity();

	$.ajax({
		type		: "POST",
		cache	: false,
		url		: "/users/sign_in",
		data		: $(this).serializeArray(),
		statusCode: {
			401: function(data){
				$.ajax({
				type		: "GET",
				cache	: false,
				url		: "/users/sign_in",
				data		: $(this).serializeArray(),
				success: function(data){
					$.fancybox(data);
				}
			})
			}
	},
	success: function() {
	    window.location.reload(true);
	}});

		return false;
	});
	});
