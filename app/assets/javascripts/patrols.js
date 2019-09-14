var patrols;
patrols = function() {

	$('.patrol-members-table').dataTable({
		paging: false,
    	info: false,
    	searching: true,
    	ordering: false,
    	"oLanguage": { "sSearch": "" },

    });

    $('.patrol-members-contact-details-table').dataTable({
    	searching: true,
    	ordering: true,
    	paging: false,
    	info: false,
    	"oLanguage": { "sSearch": "" },
  
    });

    $('.patrol-members-table').siblings('.dataTables_filter').addClass('position-relative');
    $('.patrol-members-contact-details-table').siblings('.dataTables_filter').addClass('position-relative');
    $('.position-relative input').addClass('form-control'); 
    $('.position-relative input').attr("placeholder", "Search"); 

}

$(document).ready(patrols);
$(document).on('page:load', patrols);