/**
 * Created by andy on 4/28/17.
 */
$( document ).ready(function() {

    if ($("#about-slider").length) {
        $('.about-slider').unslider({
            autoplay:true,
            arrows: false,
            infinite: true,
            fluid: true,
            dots: true,
            delay:3000
        });
    }
})
