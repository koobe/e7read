<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="jqm14" />
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
  <link href="/jquery-mobile-theme/themes/e7read.min.css" rel="stylesheet" />

  <style>
    html, body,  {
      height: 100%;
    }
    .book-cover-container, .book-cover {
      width: 100%;
      height: 100%;
      padding: 0;
    }
    .page-switcher {
      display: block;
      text-decoration: none;
      font-size: 22px;
      position: absolute;
      vertical-align: middle;
      width: 50%;
      height: 100%;
      top: 0;
    }
    .page-switcher-next {
      right: 0;
    }
  </style>
</head>
<body>

<!--
<div data-role="page" data-theme="b" class="book-cover-container" id="page-0">
  <div role="main" class="ui-content book-cover">
    <a href="#page-1" class="page-switcher page-switcher-prev">&nbsp;</a>
    <a href="#page-1" class="page-switcher page-switcher-next">&nbsp;</a>
    <div style="width: 100%; height: 100%; background-image: url(${cover}); background-repeat: no-repeat; background-size: contain; background-position: center"></div>
  </div>
</div>
-->

<g:each in="${pages}" var="page" status="i">
  <div data-role="page" data-theme="b" class="book-cover-container" id="page-${i}">
    <div role="main" class="ui-content book-cover">
      <a href="#page-${(i-1)<0?0:i-1}" class="page-switcher page-switcher-prev" data-transition="slide" data-direction="reverse">&nbsp;</a>
      <a href="#page-${i+1}" class="page-switcher page-switcher-next" data-transition="slide">&nbsp;</a>
      <div style="width: 100%; height: 100%; background-image: url(${page}); background-repeat: no-repeat; background-size: contain; background-position: center"></div>
    </div>
  </div>
</g:each>

<!--
<div class="flipbook-viewport">
  <div class="container">
    <div class="flipbook">
      <div class="page" style="background-image:url(${cover})"></div>

      <g:each in="${pages}" var="page">
        <div class="double" style="background-image:url(${page})"></div>
      </g:each>

    </div>
  </div>
</div>
-->

<script type="text/javascript">

</script>

</body>
</html>