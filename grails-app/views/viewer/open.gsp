<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">

    <link href="//cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" rel="stylesheet"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="/jquery-mobile-theme/themes/e7read.min.css" rel="stylesheet"/>

    <style>

    html, body, #viewer {
        width: 100%;
        height: 100%;
        overflow: hidden;
    }

    .page-switcher {
        display: block;
        text-decoration: none;
        font-size: 60px;
        position: absolute;
        vertical-align: middle;
        width: 10%;
        height: 100%;
        top: 0;
    }

    .page-switcher i {
        position: relative;
        top: 50%;
        transform: translateY(-50%);
        display: inline-block;
        color: #bcbcbc;
        opacity: .2;
    }

    .page-switcher:hover i {
        color: #bcbcbc;
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

    #viewer-content {
        width: 100%;
        height: 100%;
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
        width: 100%;
        height: 100%;
        background-repeat: no-repeat;
        background-size: contain;
        background-position: center;
    }

    #viewer-footer {
        color: #ffffff;
        border: none;
        background-color: #94E6DA;
        text-shadow: none;
        position: fixed;
        bottom: 0;
        width: 100%;
    }
    .page-slider .ui-slider-track.ui-mini {
        height: 6px;
        margin-left: 20px;
        border-radius: 10px;
        border-color: #fff;
        background-color: #fff;
        box-shadow: none;
    }

    .page-slider .ui-btn {
        background-color: #fff;
    }
    </style>
</head>

<body>

<div id="viewer">

    <div id="viewer-content">
        <g:each in="${pages}" var="page" status="i">
            <div class="image-rendering image-content" id="p${i}" data-url="url(${page})"></div>
        </g:each>
    </div>

    <div id="viewer-footer">
        <div class="page-slider">
            <input type="range" name="sliderPageNum" value="1" min="1" max="${pages.size()}" data-mini="true" style="display: none" />
        </div>

        <h1>${title}</h1>

        第 <span id="textCurrentPageNum">1</span> 頁 / 共 <span id="textTotalPageNum">${pages.size()}</span> 頁
    </div>

    <a href="#" class="page-switcher page-switcher-prev" data-transition="slide"
       data-direction="reverse" data-target="0" data-offset="-1" data-maximum="${pages.size()}">
        <i class="fa fa-chevron-left"></i>
    </a>

    <a href="#" class="page-switcher page-switcher-next" data-transition="slide" data-target="1" data-offset="1"
       data-maximum="${pages.size()}">
        <i class="fa fa-chevron-right"></i>
    </a>

    <input name="current" value="0" type="hidden"/>
    <input name="maximum" value="${pages.size() - 1}" type="hidden"/>
</div>

<script type="application/javascript" src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="application/javascript" src="//labs.rampinteractive.co.uk/touchSwipe/jquery.touchSwipe.min.js"></script>
<script type="text/javascript">

    $.fn.preload = function () {
        this.each(function () {
            $('<img/>')[0].src = this;
        });
    };

    var display = function (pageNum) {
        $('.image-content').hide();

        var url = $('#p' + pageNum).data('url');
        $('#p' + pageNum).css('background-image', url).show();


        // Update current page num
        $('input[name=current]').val(pageNum);
        $('#textCurrentPageNum').text(pageNum + 1);
    };

    var preload = function (page) {
        var url = $('#p' + page).data('url');
        $('#p' + page).css('background-image', url);
    };

    display(0);

    for (var i = 1; i < 5; i++) {
        preload(i);
    }

    $(function () {

        $('#viewer-content').click(function() {
            $('#viewer-footer').toggle();
        });

        $('#viewer-content').swipe( {
            swipe:function(event, direction, distance, duration, fingerCount, fingerData) {
                console.log('swipe direction: ' + direction);

                var current = parseInt($('input[name=current]').val());
                var pageNum = current + (direction=='left'?1:-1);
                console.log("(Swipe) Open Page: " + pageNum);
                display(pageNum);
            },
            //Default is 75px, set to 0 for demo so any distance triggers swipe
            threshold: 30
        });

        $('input[name=sliderPageNum]').change(function() {
            var pageNum = $('input[name=sliderPageNum]').val();
            console.log("(Slider) Open Page: " + pageNum);
            display(pageNum - 1);
        });


        //$(['${raw(pages.join("','"))}']).preload();

        $('#p0').show();

        $('a.page-switcher').click(function () {

            var current = parseInt($('input[name=current]').val());
            var maximum = parseInt($('input[name=maximum]').val());

            var offset = parseInt($(this).data('offset'));

            current += offset;

            if (current < 0) {
                current = 0;
            }
            else if (current > maximum) {
                current = maximum;
            }

            console.log(current + ', ' + maximum + ', ' + offset);

            display(current);

            for (var i = current + 1; i < current + 5; i++) {
                preload(i);
            }

            //console.log(current);

            return false;
        });
    });
</script>

</body>
</html>