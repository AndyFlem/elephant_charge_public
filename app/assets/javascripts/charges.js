

$( document ).ready(function() {
    if ( $( "#map-charges" ).length ) {
        var map_charges_div = $("#map-charges");

        map_charges = L.map('map-charges');
        map_charges.setView([map_charges_div.data("center-lat"), map_charges_div.data("center-lon")], map_charges_div.data("scale"));

        L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}", {
            attribution: '',
            maxZoom: 17
        }).addTo(map_charges);

        var myIcon = L.icon({
            iconUrl: '../assets/control_point_black.png',
            iconSize: [18, 18],
            iconAnchor: [0, 0],
            popupAnchor: [-3, -76]
        });

        $.getJSON(window.location.pathname,{format: 'json'}, function (data) {
            for (i=0; i<data.length;i++){
                console.dir(data[i])
                if(data[i].lat && data[i].lon) {
                    var marker = L.marker([data[i].lat, data[i].lon],{icon: myIcon}).addTo(map_charges);
                    var tooltip= L.tooltip({
                        offset:L.point(0,0)
                    })
                    tooltip.setTooltipContent(data[i].ref);

                    marker.bindTooltip(data[i].ref,{
                        offset:L.point(8,7),
                        direction: 'top',
                        className:'map_tooltip',
                        permanent:true
                    }).openTooltip();
                }
            }
        })
    }

})
