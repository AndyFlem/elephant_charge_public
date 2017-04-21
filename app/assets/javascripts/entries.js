

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
            iconUrl: '/system/control_point_white.png',
            iconSize: [18, 18],
            iconAnchor: [0, 0],
            popupAnchor: [-3, -76]
        });

        var orangeLine={"color": "#ff7800", "weight": 3, "opacity": 1};
        var yellowLine={"color": "yellow", "weight": 2, "opacity": 1};
        var blackLine={"color": "white", "weight": 1, "opacity": 1};

        $.getJSON('http://' + window.location.host + '/' + map_entry_div.data("charge") + '/guards',{format: 'json'}, function (data) {
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
        var legs={};
        var entry_legs={};
        $.getJSON('http://' + window.location.host + '/entry_legs/' + map_entry_div.data("entry"),{format: 'json'}, function (data) {
            //console.dir(data)
            for (i=0; i<data.length;i++){
                legs[data[i].entry_leg_id]=data[i];
                L.geoJSON(data[i].line,{style:yellowLine,
                    onEachFeature: function (feature, layer) {
                        tracks[data[i].entry_leg_id]=layer;
                    }
                }).addTo(map_entry);
            }
        });

        var ctx = $("#chartElevation");
        var chartInstance = new Chart(ctx, {
            type: 'line',
            data: {
                datasets: [{
                    data: [],
                    backgroundColor: "rgba(223,84,9,.2)",
                    borderColor: "rgba(223,84,9,1)",
                    pointRadius:0
                }]
            },
            options: {
                scales: {
                    xAxes: [{
                        type: 'linear',
                        position: 'bottom',
                        ticks:{fontSize:10},
                        scaleLabel:{display:true,labelString:'',fontSize:12}
                    }],
                    yAxes:[{
                        ticks:{fontSize:10,min:ctx.data('min-elev'),max:ctx.data('max-elev')},
                        scaleLabel:{display:true,labelString:'Elevation m',fontSize:10}
                    }]
                },
                legend:{display:false}
            }
        });


        $(".map-selector").each(function(){
            $(this).hover(function(){
                for (var key in tracks) {
                    if (tracks.hasOwnProperty(key)) {tracks[key].setStyle(yellowLine);}
                }
                layer=tracks[$(this).data('entry-leg-id')]
                layer.setStyle(orangeLine);

            })

            $(this).click(function(){
                $(".high-column").each(function(){
                    $(this).css("background-color", "white")
                    $(this).children("a").css("color", "#df5409")
                })
                $(this).parent().css( "background-color", "#f5f5f5" );
                $(this).css( "color", "#df5409" );
                layer=tracks[$(this).data('entry-leg-id')]
                map_entry .fitBounds(layer.getBounds(), {padding: [20,20]});

                leg=legs[$(this).data('entry-leg-id')]

                data=leg.elevations.map(function(e){
                    return {x:e[1],y:e[2]};
                });
                //console.dir(data)
                chartInstance.data.datasets[0].data=data
                chartInstance.options.scales.xAxes[0].scaleLabel.labelString=leg.checkin1.guard.sponsor.display_name + ' to ' + leg.checkin2.guard.sponsor.display_name
                chartInstance.update();

                $.getJSON('http://' + window.location.host + '/leg/' + leg.leg.leg_id,{format: 'json'}, function (data) {
                    for (var key in entry_legs) {
                        if (entry_legs.hasOwnProperty(key)) {
                            map_entry.removeLayer(entry_legs[key]);
                        }
                    }

                    for (i=0; i<data.length;i++){
                        if (data[i].entry.entry_id!=map_entry_div.data("entry")) {
                            L.geoJSON(data[i].line,{style:blackLine,
                                onEachFeature: function (feature, layer) {
                                    entry_legs[data[i].entry.entry_id]=layer
                                }
                            }).addTo(map_entry);
                        }else{
                            a_no=i
                        }
                    }
                    L.geoJSON(data[a_no].line,{style:orangeLine,
                        onEachFeature: function (feature, layer) {
                            entry_legs[data[a_no].entry.entry_id]=layer
                        }
                    }).addTo(map_entry);

                });

            })
        })
    }
})
