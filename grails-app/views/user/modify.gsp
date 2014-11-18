<html>
<head>
<meta name="layout" content="main"/>
<title>Modify User Profile</title>

<script src="//cdn.ckeditor.com/4.4.1/standard/ckeditor.js"></script>
<script src="//cdn.ckeditor.com/4.4.1/standard/adapters/jquery.js"></script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false"></script>

<asset:javascript src="e7read.geolocation.js"/>

<style type="text/css">
#map-canvas { width: 100%; height: 320px; }
</style>

</head>
<body>

<div class="container">

    <div class="page-header">
        <h1>Modify User Profie</h1>
    </div>

    <g:form action="modifySave" class="form-horizontal" role="form">
        <div class="form-group">
            <label for="username" class="col-sm-2 control-label">Username:</label>
            <div class="col-sm-10">
                <g:textField name="username" value="${user.username}" class="form-control" disabled="disabled" />
            </div>
        </div>

        <div class="form-group">
            <label for="fullName" class="col-sm-2 control-label">Full Name:</label>
            <div class="col-sm-10">
                <g:textField name="fullName" value="${user.fullName}" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label for="email" class="col-sm-2 control-label">E-Mail:</label>
            <div class="col-sm-10">
                <g:textField name="email" value="${user.email}" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <p class="text-center">--- Optional Fields ---</p>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.phone" class="col-sm-2 control-label">Phone:</label>
            <div class="col-sm-10">
                <g:textField name="contact.phone" value="${user.contact?.phone}" class="form-control" placeholder="Phone Number"/>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.facebookUrl" class="col-sm-2 control-label">Facebook:</label>
            <div class="col-sm-10">
                <g:textField name="contact.facebookUrl" value="${user.contact?.facebookUrl}" class="form-control" placeholder="http://facebook.com/YourFacebookID"/>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.blogUrl" class="col-sm-2 control-label">Blog:</label>
            <div class="col-sm-10">
                <g:textField name="contact.blogUrl" value="${user.contact?.blogUrl}" class="form-control" placeholder="http://${user.username}.blogspot.com/"/>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.lineId" class="col-sm-2 control-label">LINE:</label>
            <div class="col-sm-10">
                <g:textField name="contact.lineId" value="${user.contact?.lineId}" class="form-control" placeholder=""/>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.skypeId" class="col-sm-2 control-label">Skype:</label>
            <div class="col-sm-10">
                <g:textField name="contact.skypeId" value="${user.contact?.skypeId}" class="form-control" placeholder=""/>
            </div>
        </div>

        <div class="form-group">
            <label for="contact.description" class="col-sm-2 control-label">Description:</label>
            <div class="col-sm-10">
                <g:textArea name="contact.description" value="${user.contact?.description}" class="form-control" rows="5" />
            </div>
        </div>

        <div class="form-group">

            <input type="hidden" name="lat" value="${user.location?.lat}" />
            <input type="hidden" name="lon" value="${user.location?.lon}" />
            <input type="hidden" name="geolocation" value="${user.location?.lat},${user.location?.lon}" />


            <label class="col-sm-2 control-label">Location:</label>
            <div class="col-sm-10">

                <!-- Display Location -->
                <g:link controller="map" action="prompt" class="location-link" target="_blank" title="Click to modify">
                    <i class="fa fa-map-marker"></i>
                    <span id="locationDisplayName">${user.location?.city}</span>
                </g:link>

                <!--
                <div class="col-sm-6">
                    <div id="map-canvas"></div>
                </div>
                <div class="col-sm-6">
                    <br/>
                    <label>Search</label>
                    <input name="customAddress" value="" class="form-control" />
                    <br/>
                    <a href="#" id="customAddressSubmit" class="btn btn-default btn-block">Search</a>
                </div>
                -->

            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <g:submitButton name="save" value="Save" class="btn btn-default" />
                <g:link controller="user" action="profile" class="btn btn-default">Cancel</g:link>
            </div>
        </div>

    </g:form>

</div>

<script type="text/javascript">
$(function() {
    $('textarea[name="contact.description"]').ckeditor();

    /*
    var myLatlng = new google.maps.LatLng(${user.location?.lat?:24}, ${user.location?.lon?:120});

    var mapOptions = {
        center: myLatlng,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    var geocoder = new google.maps.Geocoder();

    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: "I'm here!!!",
        draggable: true,
        animation: google.maps.Animation.DROP
    });

    google.maps.event.addListener(marker, 'dragend', function(event) {

        // Upload location info
        var callbackUrl = $('meta[name=geo-callback-url]').attr('content');

        $.ajax({
            url: callbackUrl,
            data: {
                lat: event.latLng.lat(),
                lon: event.latLng.lng()
            },
            success: function() {
                // none
            }
        });
    });


    $('a#customAddressSubmit').unbind('click').click(function() {
        var address = $('input[name=customAddress]').val();

        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                //Got result, center the map and put it out there
                map.setCenter(results[0].geometry.location);

                marker.setPosition(results[0].geometry.location);

            } else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });

        return false;
    });

    $('input[name=customAddress]').keydown(function(event) {
        if ( event.which == 13 ) {
            event.preventDefault();
            $('a#customAddressSubmit').trigger('click');
        }
    });
    */

    $('input[name=geolocation]').change(function() {
        var geolocation = $(this).val();
        $.geoupdate({
            lat: $('input[name=lat]').val(),
            lon: $('input[name=lon]').val(),
            callback: function(data) {
                $('#locationDisplayName').text(data.display);
            }
        });
    });

});
</script>
</body>
</html>