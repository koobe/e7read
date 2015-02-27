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
      <g:link action="legacy" class="btn btn-default">返回</g:link>
    </div>

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
      var btn = $(this);
      var file = $(this).data('file');

      console.log("Fetch XML: " + file);

      $.ajax('/legacy/legacyFetchXML', {
        type: 'post',
        data: {
          file: file
        },
        success: function(result) {

          btn.hide();

          console.log("XML fetched.");
          if (result && result.message) {
            console.log(result.message);
            alert(result.message);
          }
        }
      });

      return false;
    });
  });
</script>
</body>
</html>