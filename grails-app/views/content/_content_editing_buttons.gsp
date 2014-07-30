<!-- 
<g:link class="koobe-btn button" title="View" uri="javascript: showContent('${it.id}');">
	<span class="fa fa-eye"></span>
</g:link>
 -->
<g:if test="${it.isShowContact}">
	<g:link class="koobe-btn koobe-btn-normal koobe-btn-inverse button-show-contact" title="Hide vCard" data-id="${it.id}" data-url="${createLink(action: 'ajaxInlineUpdate', id: it.id)}" data-value="false" uri="#">
		<span class="fa fa-user"></span>
	</g:link>
</g:if>
<g:if test="${!it.isShowContact}">
	<g:link class="koobe-btn koobe-btn-normal button-show-contact" title="Show vCard" data-id="${it.id}" data-url="${createLink(action: 'ajaxInlineUpdate', id: it.id)}" data-value="true" uri="#">
		<span class="fa fa-user"></span>
	</g:link>
</g:if>
 
<g:link class="koobe-btn koobe-btn-normal button-modify-references" title="Reference URL" uri="#" data-id="${it.id}" data-url="${createLink(action: 'ajaxInlineUpdate', id: it.id)}">
    <span class="fa fa-link"></span>
</g:link>

<g:if env="development">
    <g:link class="koobe-btn koobe-btn-normal" title="Edit" controller="content" action="edit" id="${it.id}">
        <span class="fa fa-pencil-square-o"></span>
    </g:link>
</g:if>

<g:link class="koobe-btn koobe-btn-normal" title="Delete" uri="javascript: deleteContent('${it.id}');">
	<span class="fa fa-times"></span>
</g:link>
<g:if test="${!it.isPrivate}">
	<g:link class="koobe-btn koobe-btn-normal linkprivate" title="Make private" uri="javascript: switchPrivacy('${it.id}');">
		<span class="fa fa-lock"></span>
	</g:link>
</g:if>
<g:if test="${it.isPrivate}">
	<g:link class="koobe-btn koobe-btn-normal koobe-btn-inverse linkpublic" title="Make public" uri="javascript: switchPrivacy('${it.id}');">
		<span class="fa fa-lock"></span>
	</g:link>
</g:if>