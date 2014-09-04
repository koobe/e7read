<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
    <asset:stylesheet src="default_template.css"/>

</head>
<body data-linkify="p, .plain-text" id="content-body">
    <div class="template-container">

        <div class="pictures-container">
            <table class="picture-rtable">
                <tr>
                  <td rowspan="2">
                    <div class="picture-native" style="background-image:url(${content.pictureSegments[0]?.originalUrl});" data-imageurl="${content.pictureSegments[0]?.originalUrl}"></div>
                  </td>
                  <td>
                    <div class="picture-native" style="background-image:url(${content.pictureSegments[1]?.originalUrl});" data-imageurl="${content.pictureSegments[1]?.originalUrl}"></div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="picture-native" style="background-image:url(${content.pictureSegments[2]?.originalUrl});" data-imageurl="${content.pictureSegments[2]?.originalUrl}"></div>
                  </td>
                </tr>
            </table>
        </div>

        <div class="title-container border-btm margin-lr-20">
            <div class="content-title">
                <h1>${content.cropTitle}</h1>
            </div>
            <div style="display:table; width:100%;">
                <div class="content-author" style="display:table-cell;">
                    <span class="author-click" data-user-id="${content.user.id}">${content.user.fullName}</span>
                </div>
                <div class="content-author" style="display:table-cell; text-align: right;">
                    <span style="font-size: 0.7em; color: #333;"><g:formatDate date="${content.datePosted}" format="yyyy/MM/dd HH:mm:ss" /></span>
                </div>
            </div>
        </div>

        <div class="margin-lr-20">
            <g:if test="${content.categories}">
                <div class="content-category-tags-table text-uppercase">
					<g:each in="${content.categories}" var="category">
						<div>
							<a class="content-category-name" data-categoryName="${category.name}">
								<span data-categoryName="${category.name}" class="label">
									<g:message code="category.name.i18n.${category.name}" default="${category.name}" />
								</span>
							</a>
						</div>
					</g:each>
				</div>
            </g:if>
            <div class="pull-right social-toolbar">
                <g:if test="${content.references}">
                    <g:link uri="${content.references}" target="_blank">
                        <i class="fa fa-external-link"></i>
                        Source
                    </g:link>
                </g:if>
                <a href="https://www.facebook.com/sharer/sharer.php?u=${URLEncoder.encode(shareUrl, 'UTF-8')}" target="_blank">
                    <i class="fa fa-facebook-square"></i>
                    Share
                </a>
            </div>
        </div>

        <div class="margin-blank"></div>

        <div class="text-container padding-lr">
            <div>
                <g:each in="${content.textSegments}" var="segment">
                    <markdown:renderHtml>${segment.text}</markdown:renderHtml>
                </g:each>
            </div>
        </div>

        <div class="margin-blank"></div>
    </div>
    <g:render template="/home/footer" />

    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//soapbox.github.io/jQuery-linkify/dist/jquery.linkify.min.js"></script>
    
    <asset:stylesheet src="imageview.css"/>
	<asset:javascript src="jquery.imageview.js"/>
	<asset:stylesheet src="gototop.css"/>
	<asset:javascript src="jquery.gototop.js"/>
	<asset:stylesheet src="e7read_categorystatus.css" />
	<asset:javascript src="jquery.e7read.categorystatus.js"/>
	
    <asset:javascript src="default_template.js" />
</body>
</html>
