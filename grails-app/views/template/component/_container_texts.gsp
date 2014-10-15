<div class="text-container">
    <g:each in="${content.textSegments}" var="segment">
        <markdown:renderHtml>${segment.text}</markdown:renderHtml>
    </g:each>
</div>