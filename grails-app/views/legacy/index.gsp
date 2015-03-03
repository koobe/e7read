<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main"/>
  <title></title>
</head>
<body>
<div class="container">


  <div class="page-header">

  <div class="btn-group pull-right" role="group">
    <g:link action="legacyImport" class="btn btn-default">
      <i class="fa fa-plus"></i>
      Import
    </g:link>

    <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
  </div>

  <h2>Legacy EPUB</h2>
</div>

  <table class="table table-bordered table-striped table-hover table-responsive">
    <tr>
      <th width="30">#</th>
      <th width="30%">Book Title</th>
      <th>Description</th>
      <th>Actions</th>
    </tr>
    <g:each in="${legacies}" var="legacy" status="i">
      <tr>
        <td align="right">${i+1}</td>
        <td>
          <p><small>${legacy.title}</small></p>
          <p>
            <g:link controller="legacy" action="opf" id="${legacy.id}">content.opf</g:link>
            |
            <g:link controller="viewer" action="open" params="[legacy: legacy.id]">preview</g:link>
            |
            <g:link controller="viewer" action="open" params="[book: legacy.bookId]">book</g:link>
          </p>
          <g:if test="${legacy.coverKey}">
            <img src="${createLink(controller: 'legacy', action: 'cover', id: legacy.id)}" alt="cover" class="img-thumbnail" style="max-width:150px" />
          </g:if>
        </td>
        <td>
          <p><small>${legacy.description}</small></p>
          <p class="text-info"><small>${legacy.publisher} / ${legacy.date} / ${legacy.language} / ${legacy.subject}</small></p>
          <p><small><code>${legacy.s3key}</code></small></p>
          <%--<pre>${legacy.opf}</pre>--%>
          <%--<pre>${legacy.imageItems}</pre>--%>
        </td>
        <td>
          <div class="btn-group btn-group-xs">
            <button class="btn btn-default btn-xs btnFetchXML" data-file="${legacy.id}">Import</button>
          </div>
        </td>
      </tr>
    </g:each>
  </table>
</div>

<script type="application/javascript">
  $(function() {
    $('.btnFetchXML').click(function() {
      var file = $(this).data('file');

      console.log("Import Legacy: " + file);

//      $.ajax('/book/legacyFetchXML', {
//        type: 'post',
//        data: {
//          file: file
//        },
//        success: function() {
//          console.log("XML fetched.");
//        }
//      })

      return false;
    });
  });
</script>
</body>
</html>