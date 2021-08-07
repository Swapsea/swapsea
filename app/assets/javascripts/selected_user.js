var selected_user;
selected_user = function() {

	$('#switch-user-table').dataTable({
		paging: false,
    	info: false,
    	searching: true,
    	ordering: true,
    	"oLanguage": { "sSearch": "" }
    });

    $('.dataTables_filter').addClass('position-relative');
    $('.dataTables_filter input').addClass('form-control'); 
    $('.dataTables_filter input').attr("placeholder", "Search"); 

}

$(document).ready(selected_user);
$(document).on('page:load', selected_user);
