<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
    html { height: 100% }
    body { height: 100%; margin: 0; padding: 0 }
    #map_canvas { height: 100% }
    </style>
    <script type="text/javascript"
            src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false">
    </script>
    <script type="text/javascript">

        function initialize() {
            var myLatlng = new google.maps.LatLng(${lat}, ${lon});

            var mapOptions = {
                center: myLatlng,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map = new google.maps.Map(document.getElementById("map_canvas"),
                    mapOptions);

            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: "Your Location!",
                draggable:true,
                animation: google.maps.Animation.DROP
            });

            var contentString = '<h3>GoPro Hero 4 正式登場</h3><p>近年氣勢甚強的 GoPro，新一代的 HERO 4 已經傳聞很久，但一直未有現身。最近終於有較為可信的消息出現，而且還有詳細的照片和規格，看來也是個大型更新。</p><p>Read more... <b>E7READ</b></p>';

            var infowindow = new google.maps.InfoWindow({
                content: contentString
            });

            google.maps.event.addListener(marker, 'click', function() {
                infowindow.open(map,marker);
            });
        }
    </script>
</head>
<body onload="initialize()">
<div id="map_canvas" style="width:100%; height:100%"></div>
</body>
</html>