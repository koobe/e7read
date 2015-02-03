<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="jqm14"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="/jquery-mobile-theme/themes/e7read.min.css" rel="stylesheet"/>

    <style>
    .in, .out {
        -webkit-animation-timing-function: ease-in-out;
        -webkit-animation-duration: 250ms !important;
    }

    html, body, {
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
        font-size: 100px;
        position: absolute;
        vertical-align: middle;
        width: 20%;
        height: 100%;
        top: 0;
    }

    .page-switcher i {
        width: 100%;
        color: #d3d3d3;
        opacity: .1;
    }

    .page-switcher i:hover {
        color: #d3d3d3;
        opacity: 1;
    }

    .page-switcher-prev {
        left: 0;
        text-align: left;
    }

    .page-switcher-next {
        right: 0;
        text-align: right;
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

    .image-content {
        display: none;
        width: 100%; height: 100%; background-repeat: no-repeat; background-size: contain; background-position: center;
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

    <div data-role="page" data-theme="b" class="book-cover-container">
        <div role="main" class="ui-content book-cover">

            <a href="#" class="page-switcher page-switcher-prev" data-transition="slide"
               data-direction="reverse" data-target="0" data-offset="-1" data-maximum="${pages.size()}">
                <i class="fa fa-chevron-left"></i>
            </a>
            <a href="#" class="page-switcher page-switcher-next" data-transition="slide" data-target="1" data-offset="1" data-maximum="${pages.size()}">
                <i class="fa fa-chevron-right"></i>
            </a>

            <g:each in="${pages}" var="page" status="i">
                <div class="image-rendering image-content" id="p${i}" data-url="url(${page})"></div>
            </g:each>

            <input name="current" value="0" />
            <input name="maximum" value="${pages.size()}" />

        </div>

        <div data-role="footer" data-position="fixed">
            <h1>Fixed Footer!</h1>
        </div>
    </div>


<script type="text/javascript">

    $.fn.preload = function () {
        this.each(function () {
            $('<img/>')[0].src = this;
        });
    };

    var display = function(page) {
        var url = $('#p' + page).data('url');
        $('#p' + page).css('background-image', url).show();
    };

    var preload = function(page) {
        var url = $('#p' + page).data('url');
        $('#p' + page).css('background-image', url);
    };

    display(0);

    for (var i = 1; i < 5; i++) {
        preload(i);
    }


    $(function () {
        //  $('a.page-switcher').unbind('click').click(function() {
        //    $(this).hide();
        //  });

        //$(['${raw(pages.join("','"))}']).preload();

        $('#p0').show();

        $('a.page-switcher').click(function() {
            $('.image-content').hide();

            var current = parseInt($('input[name=current]').val());
            var maximum = parseInt($('input[name=maximum]').val());

            var offset = parseInt($(this).data('offset'));

            current += offset;

            console.log(current + ', ' + maximum + ', ' + offset);

            if (current < 0) {
                current = 0;
            }
            else if (current >= maximum) {
                current = maximum - 1;
            }

            display(current);

            for (var i = current + 1; i < current + 5; i++) {
                preload(i);
            }

            $('input[name=current]').val(current);

            //console.log(current);

            return false;
        });
    });
</script>

</body>
</html>