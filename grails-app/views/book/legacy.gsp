<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main"/>
  <title></title>
</head>
<body>
<div class="container">
  <h3>Convert legacy EPUB files to Book database</h3>
  <table class="table table-bordered table-striped table-hover table-responsive">
    <tr>
      <th>#</th>
      <th>EPUB File</th>
      <th>Title</th>
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
            <button class="btn btn-default btn-xs" id="btnFetchXML" data-file="${file}">Fetch XML</button>
            <button class="btn btn-default btn-xs">Import XML</button>
          </div>
        </td>
      </tr>
    </g:each>
  </table>
</div>

<script type="application/javascript">
  $(function() {
    $('#btnFetchXML').click(function() {
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