$(document).ready(function() {
	console.log("js loaded");
	$('body').on("change", "select.dropdown-produs", function(event) {
		currentDropdownProdus = event.currentTarget;
		selectedDropdownIndex = $(currentDropdownProdus).val();

		tablerow = $(currentDropdownProdus).parents('tr')[0];
		$(tablerow).find('select.dropdown-pret').val(selectedDropdownIndex);
		$(tablerow).find('select.dropdown-scor').val(selectedDropdownIndex);
	});
})