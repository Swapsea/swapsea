var offers;
offers = function() {

	$('.offer-accept-table').dataTable({
		paging: false,
    	info: false,
    	searching: false,
    	ordering: false,
        "scrollX": true,
    	"oLanguage": { "sSearch": "" }
    });

    $('.dataTables_filter').addClass('position-relative');
    $('.dataTables_filter input').addClass('form-control'); 
    $('.dataTables_filter input').attr("placeholder", "Search"); 


    $('#btn-accept').click(function(event){
        event.preventDefault();
        $('#btn-accept').html('<i class="fa fa-spinner fa-pulse"></i><br/>Processing...');
        $('#btn-accept').addClass('btn-disabled').attr('disabled', true);
        var url = $('#btn-accept').parent('a').attr('href');
        window.location.replace(url);
    });

}

$(document).ready(offers);
$(document).on('page:load', offers);