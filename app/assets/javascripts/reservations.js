$(document).ready(function() {
	$('.datetimepicker_in').datetimepicker({
		format: 'DD-MM-YYYY',
		minDate: new Date(),
		disabledDates: []
	});
	$('.datetimepicker_in').on('dp.change', function(e) {	
		$checkin_date_string = e.target.value;
		$checkin_date_string_split = $checkin_date_string.split('-');
		$checkin_date = new Date($checkin_date_string_split[2], $checkin_date_string_split[1] - 1, $checkin_date_string_split[0])
		$checkin_date.setDate($checkin_date.getDate() + 1)
		$('.datetimepicker_out').data("DateTimePicker").minDate($checkin_date)
	});
	
	$('.datetimepicker_out').datetimepicker({
		format: 'DD-MM-YYYY',
		minDate: new Date(),
	});
})
