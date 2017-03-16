// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require bootstrap-sprockets
//= require jquery_ujs

//= require leaflet

//= require unslider-min

//= require_tree .

var photo_no;
var srcs;
var aspects;
var description;

$( document ).ready(function() {
    if ($("#fb-page").length) {
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    }
    if ($("#banner").length) {


        $('.banner').unslider({
            autoplay:true,
            arrows: false,
            infinite: true,
            fluid: true,
            dots: true,
            delay:10000
        });
    }
    $('#imageModal-left').click(function(){
        photo_no-=1;
        if (photo_no<0)
        {
            photo_no=srcs.length-1
        }
        src=srcs[photo_no]
        aspect=aspects[photo_no]
        $('#modalTitle').text((photo_no+1) + ' of ' + srcs.length + ' - ' + description);
        setImage($('#modalImageElement'),src, aspect)
    })
    $('#imageModal-right').click(function(){
        photo_no+=1;
        if (photo_no>(srcs.length-1))
        {
            photo_no=0
        }
        src=srcs[photo_no]
        aspect=aspects[photo_no]
        $('#modalTitle').text((photo_no+1) + ' of ' + srcs.length + ' - ' + description);
        setImage($('#modalImageElement'), src, aspect)
    })

})

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})

$(function () {
    $('[data-toggle="popover"]').popover()
})

showModal=function (el) {

    $('#imageModal').modal();

    srcs=$(el).data('srcs')
    aspects=$(el).data('aspects')
    description=$(el).data('description')
    photo_no=$(el).data('photo-no')
    $('#modalTitle').text((photo_no+1) + ' of ' + srcs.length + ' - ' + description);
    src=srcs[photo_no]
    aspect=aspects[photo_no]
    setImage($('#modalImageElement'),src,aspect)
}

setImage=function (image_elm,src,landscape){
    image_elm.attr("src", "/system/clear.gif");
    image_elm.css("height","451px");
    console.log(landscape)
    var $downloadingImage = $("<img>");
    $downloadingImage.load(function(){
        setTimeout(function() {
                if (landscape==1)
                {
                    image_elm.css("width","100%");
                }
                else
                {
                    image_elm.css("width","50%");

                }
                image_elm.css("height","inherit");
                image_elm.attr("src",  $(this).attr("src"));
        },1

        )

    });
    $downloadingImage.attr("src", src);
}
