<div class="pull-right social-toolbar">

    <i class="fa fa-map-marker"></i>
    ${content.location?.city}
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