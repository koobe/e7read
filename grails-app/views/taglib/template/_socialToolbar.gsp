<div class="pull-right social-toolbar">

    <g:if test="${content.location}">
        <g:link controller="map" action="explore" params="[center: content.location?.lat+','+content.location?.lon]">
            <i class="fa fa-map-marker"></i>
            ${content.location?.city}
        </g:link>
    </g:if>

    <%--
    <!--${address?.addressComponents[3]?.shortName}-->
    <!--${content.location.lat}, ${content.location.lon}-->
    --%>

    <g:if test="${content.references}">
        <g:link uri="${content.references}" target="_blank">
            <i class="fa fa-external-link"></i>
            Source
        </g:link>
    </g:if>

    <!--<a href="#" target="_blank">
        <i class="fa fa-share-square"></i>
        Share
    </a>-->

    <a href="https://www.facebook.com/sharer/sharer.php?u=${URLEncoder.encode(createLink(controller: 'content', action: 'share', id: content.id, absolute: true), 'UTF-8')}" target="_blank">
        <i class="fa fa-facebook-square"></i>
        Share
    </a>
</div>