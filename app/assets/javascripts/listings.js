$(document).ready(function() {
	$('#filter-button').on('click', function() {
		$('#filter').toggle();
	});

	$('#filter-price-button').on('click', function() {
		$('#filter-price').toggle();
	});

	$('#filter-city-button').on('click', function() {
		$('#filter-city').toggle();
	});

	$("#filter-price-bar").on('input', function() {
  	var newValue = $('#filter-price-bar').val();
   	$("#filter-price-value").html("below RM " + newValue);
	});
})
