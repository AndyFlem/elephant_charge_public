

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
            iconUrl: '../assets/control_point_black.png',
            iconSize: [18, 18],
            iconAnchor: [0, 0],
            popupAnchor: [-3, -76]
        });


    }

})
