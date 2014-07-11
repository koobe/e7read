<g:link class="btn btn-primary button" uri="javascript: void(0)">Edit</g:link>
<g:link class="btn btn-primary button" uri="javascript: deleteContent('${it.id}');">Delete</g:link>
<g:if test="${it.isPrivate != true}">
	<g:link class="btn btn-primary button linkprivate" uri="javascript: switchPrivacy('${it.id}');">Make Private</g:link>
</g:if>
<g:if test="${it.isPrivate}">
	<g:link class="btn btn-primary button linkpublic" uri="javascript: switchPrivacy('${it.id}');">Make Public</g:link>
</g:if>