<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main"/>
  <title></title>
</head>
<body>
<div class="container">
  <g:link action="legacy">List</g:link>
  <div class="page-header">
    <h2>Import EPUB</h2>
  </div>
  <table class="table table-bordered table-striped table-hover table-responsive">
    <tr>
      <th>#</th>
      <th>EPUB File</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>
    <g:each in="${files}" var="file" status="i">
      <tr>
        <td>${i+1}</td>
        <td><small>${file}</small></td>
        <td>
          <span class="text-warning">Read XML First</span>
        </td>
        <td>
          <div class="btn-group btn-group-xs">
            <button class="btn btn-default btn-xs btnFetchXML" data-file="${file}">Get Data</button>
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

      console.log("Fetch XML: " + file);

      $.ajax('/book/legacyFetchXML', {
        type: 'post',
        data: {
          file: file
        },
        success: function() {
          console.log("XML fetched.");
        }
      })

      return false;
    });
  });
</script>
</body>
</html>