$(document).ready(function() {
	$('.datetimepicker_in').datetimepicker({
		format: 'DD-MM-YYYY',
		minDate: new Date(),
	});

	// $checkin_date_string = $('.datetimepicker_in')[0].value;
	// $checkin_date_string_split = $checkin_date_string.split('-');
	// $checkin_date = new Date($checkin_date_string_split[2], $checkin_date_string_split[1] - 1, $checkin_date_string_split[0])
	
	$('.datetimepicker_out').datetimepicker({
		format: 'DD-MM-YYYY',
		// minDate: new Date($checkin_date),
		minDate: new Date(),
	});
})
