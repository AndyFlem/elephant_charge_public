

$( document ).ready(function() {
    if ( $( "#map-entry" ).length ) {

        var map_entry_div = $("#map-entry");

        map_entry = L.map('map-entry');
        map_entry.setView([map_entry_div.data("center-lat"), map_entry_div.data("center-lon")], map_entry_div.data("scale"));

        L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", {
            attribution: '',
            maxZoom: 17
        }).addTo(map_entry);

        var myIcon = L.icon({
            iconUrl: '../assets/control_point_white.png',
            iconSize: [18, 18],
            iconAnchor: [0, 0],
            popupAnchor: [-3, -76]
        });

        var orangeLine={"color": "#ff7800", "weight": 3, "opacity": 1};
        var redLine={"color": "red", "weight": 2, "opacity": 1};
        var blackLine={"color": "black", "weight": 2, "opacity": 1};

        $.getJSON('http://' + window.location.host + '/' + map_entry_div.data("charge") + '/guards', function (data) {
            for (i=0; i<data.length;i++){

                if(data[i].lat && data[i].lon) {
                    var marker = L.marker([data[i].lat, data[i].lon],{icon: myIcon}).addTo(map_entry);
                    var tooltip= L.tooltip({
                        offset:L.point(0,0)
                    })
                    tooltip.setTooltipContent(data[i].sponsor.display_name);

                    marker.bindTooltip(data[i].sponsor.display_name,{
                        offset:L.point(8,7),
                        direction: 'top',
                        className:'map_tooltip',
                        permanent:true
                    }).openTooltip();
                }
            }
        })

        var tracks={};
        $.getJSON('http://' + window.location.host + '/entry_legs/' + map_entry_div.data("entry"), function (data) {
            for (i=0; i<data.length;i++){
                L.geoJSON(data[i].line,{style:blackLine,
                    onEachFeature: function (feature, layer) {
                        tracks[data[i].entry_leg_id]=layer;
                    }
                }).addTo(map_entry);
            }
        });

        $(".map-selector").each(function(){
            $(this).hover(function(){
                for (var key in tracks) {
                    if (tracks.hasOwnProperty(key)) {tracks[key].setStyle(blackLine);}
                }
                layer=tracks[$(this).data('entry-leg-id')]
                layer.setStyle(orangeLine);

            })
            $(this).click(function(){
                layer=tracks[$(this).data('entry-leg-id')]
                map_entry .fitBounds(layer.getBounds(), {padding: [20,20]});
            })
        })
    }
})
