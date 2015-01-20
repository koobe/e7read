<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="jqm14" />
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
  <link href="/jquery-mobile-theme/themes/e7read.min.css" rel="stylesheet" />

  <style>
  .in, .out {
    -webkit-animation-timing-function: ease-in-out;
    -webkit-animation-duration: 250ms !important;
  }
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
    .image-rendering {
      /*image-rendering: optimizeQuality; -ms-interpolation-mode:bicubic;*/
      /*image-rendering: -webkit-pixelated;*/
      image-rendering: pixelated;
      image-rendering: optimize-contrast;
      /*image-resolution: 300dpi;*/
      image-resolution: 72dpi;
      /*image-rendering:-moz-crisp-edges; image-rendering: -o-crisp-edges; image-rendering:-webkit-optimize-contrast; -ms-interpolation-mode:nearest-neighbor;*/
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
      <div class="image-rendering" style="width: 100%; height: 100%; background-image: url(${page}); background-repeat: no-repeat; background-size: contain; background-position: center;"></div>
    </div>
  </div>
</g:each>


<script type="text/javascript">
$.fn.preload = function() {
  this.each(function(){
    $('<img/>')[0].src = this;
  });
};


$(function() {
//  $('a.page-switcher').unbind('click').click(function() {
//    $(this).hide();
//  });

  $(['${raw(pages.join("','"))}']).preload();


});
</script>

</body>
</html>