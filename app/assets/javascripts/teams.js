/**
 * Created by andy on 4/27/17.
 */
$( document ).ready(function() {
    if ($("#teamselect_1").length) {
        $("#teamselect_1").change(function() {
            window.location.href='/compare/' + $("#teamselect_1").find(":selected").val() + '/' + $("#teamselect_2").find(":selected").val()
        })
        $("#teamselect_2").change(function() {
            window.location.href='/compare/' + $("#teamselect_1").find(":selected").val() + '/' + $("#teamselect_2").find(":selected").val()
        })
    }
})
