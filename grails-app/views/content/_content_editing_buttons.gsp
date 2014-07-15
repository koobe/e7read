<g:link class="btn btn-default button" uri="javascript: void(0)">
	<span class="fa fa-pencil-square-o"></span>
</g:link>
<g:link class="btn btn-default button" uri="javascript: deleteContent('${it.id}');">
	<span class="fa fa-times"></span>
</g:link>
<g:if test="${it.isPrivate != true}">
	<g:link class="btn btn-default button linkprivate" uri="javascript: switchPrivacy('${it.id}');">
		<span class="fa fa-lock"></span>
	</g:link>
</g:if>
<g:if test="${it.isPrivate}">
	<g:link class="btn btn-default button linkpublic" uri="javascript: switchPrivacy('${it.id}');">
		<span class="fa fa-globe"></span>
	</g:link>
</g:if>