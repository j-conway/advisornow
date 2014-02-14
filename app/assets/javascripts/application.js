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
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-timepicker.min
//= require turbolinks
//= require_tree .

$(function() {
	
	$('.form-control.date').datepicker({
		startDate: '-1d',
		autoclose: true,
		dateFormat: 'mm/dd/yyyy'
	});
	$('.form-control.date').datepicker("setDate", new Date());

	$('.form-control.timepicker').timepicker({
	});

	$('.form-control.change-date').datepicker({
		startDate: '-1d',
		autoclose: true,
		dateFormat: 'mm/dd/yyyy',
		defaultDate: 'value'
	});
	$('.form-control.change-timepicker').timepicker({
		defaultTime: 'value'
	});

	if( $('.alpine-select').is(':checked'))
	    $(".non-alpine").hide();	
    else
        $(".non-alpine").show();
	    

	$('.alpine-select').click(function() {
	    if( $(this).is(':checked')) {
	        $(".non-alpine").hide(),
	        $(".alpine").show();
	    } else {
	        $(".non-alpine").show(),
	        $(".alpine").hide();
	    }
	}); 
});



$("#timeIcon").click(function(){
  $("#timeInput").click();
});


