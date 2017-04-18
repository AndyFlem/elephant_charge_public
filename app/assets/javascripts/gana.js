/**
 * Created by andy on 4/18/17.
 */

$( document ).ready(function() {
    if ($("#paypal_form").length) {

        $( "#paypal_form" ).submit(function( event ) {
            
            ga('send', 'event', 'Paypal', 'click', 'Team',$(this).parent().data('team-id'));
            //event.preventDefault();
        });
    }
})


