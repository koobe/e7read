<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">

    <link href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css" rel="stylesheet"/>
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
        padding: 20px 10px;
    }

    #viewer-footer .col-left, .col-center, .col-right {
        display: inline-block;
        width: 33%;
    }

    #viewer-footer .col-left {
        float: left;
    }

    #viewer-footer .col-right {
        float: right;
    }

    #viewer-footer h1 {
        display: inline-block;
        font-size: 11pt;
        font-family: 'DejaVu Serif', Georgia, "Times New Roman", Times, serif;
    }

    #slider {
        border: none;
        height: 9px;
        margin-bottom: 10px;
    }

    #slider .ui-slider-handle {
        border-radius: 25px;
        width: 18px;
        height: 18px;
        top: -6px;
    }

    #slider .ui-slider-handle.ui-state-default {
        border-color: #fff;
        background-color: #fff !important;
        background-image: none;
    }

    #slider .ui-slider-handle.ui-state-active {
        border-color: #fff;
        background-color: #e6e6e6 !important;
        background-image: none;
    }

    .page-num-display {
        font-size: 11px;
        font-family: 'Bitstream Vera Sans Mono', 'DejaVu Sans Mono', 'Monaco', Courier, monospace;
        display: inline-block;
        width: 7em;
        text-align: right;
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

    <a href="#" class="page-switcher page-switcher-prev" data-transition="slide"
       data-direction="reverse" data-target="0" data-offset="-1" data-maximum="${pages.size()}">
        <i class="fa fa-chevron-left"></i>
    </a>

    <a href="#" class="page-switcher page-switcher-next" data-transition="slide" data-target="1" data-offset="1"
       data-maximum="${pages.size()}">
        <i class="fa fa-chevron-right"></i>
    </a>

    <div id="viewer-footer">

        <div class="col-left">
            <div style="display: table-cell; vertical-align: middle; padding-right: 5px; font-size: 160%">
                <i class="fa fa-caret-left"></i>
            </div>
            <div style="display: table-cell;vertical-align: middle;">
                <h1>${title}</h1>
            </div>
        </div>

        <div class="col-right">
            <div style="text-align: center; font-size: 160%">
                <i class="fa fa-star"></i>
                <i class="fa fa-info-circle"></i>
                <i class="fa fa-list"></i>
            </div>
        </div>

        <div class="col-center">
            <div style="display: inline-block; width: 100%;">
                <div id="slider" data-min="1" data-max="${pages.size()}"></div>
                <div class="page-num-display">
                    <span id="textCurrentPageNum">1</span> / <span id="textTotalPageNum">${pages.size()}</span>
                </div>
            </div>
        </div>

    </div>

    <input name="current" value="0" type="hidden"/>
    <input name="maximum" value="${pages.size() - 1}" type="hidden"/>
</div>

<script type="application/javascript" src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="application/javascript" src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="application/javascript" src="//raw.githubusercontent.com/furf/jquery-ui-touch-punch/master/jquery.ui.touch-punch.min.js"></script>
<script type="application/javascript" src="//labs.rampinteractive.co.uk/touchSwipe/jquery.touchSwipe.min.js"></script>
<script type="text/javascript">

    $.fn.preload = function () {
        this.each(function () {
            $('<img/>')[0].src = this;
        });
    };

    var preload = function (page) {
        var url = $('#p' + page).data('url');
        $('#p' + page).css('background-image', url);
    };

    var display = function (pageNum) {
        console.log("display(" + pageNum + ");");

        $('.image-content').hide();

        var maximum = parseInt($('input[name=maximum]').val());

        if (pageNum < 0) {
            pageNum = 0;
        }
        else if (pageNum > maximum) {
            pageNum = maximum;
        }

        console.log("display page: " + pageNum + ', ' + maximum);

        var url = $('#p' + pageNum).data('url');
        $('#p' + pageNum).css('background-image', url).show();

        for (var i = pageNum + 1; i < pageNum + 5; i++) {
            preload(i);
        }

        // Update current page num
        $('input[name=current]').val(pageNum);
        $('#textCurrentPageNum').text(pageNum + 1);
    };

    display(0);

    $(function () {

        $( "#slider" ).slider({
            min: $('#slider').data('min'),
            max: $('#slider').data('max'),
            change: function(event, ui) {
                var pageNum = parseInt($(this).slider('value'));
                console.log("(Slider) Open Page: " + pageNum);
                display(pageNum - 1);
            },
            start: function(event, ui) {
                var pageNum = parseInt($(this).slider('value'));
                console.log("(Slider) Start Preview: " + pageNum);
            },
            slide: function(event, ui) {
                var pageNum = parseInt($(this).slider('value'));
                console.log("(Slider) Preview: " + pageNum);
                display(pageNum - 1);
            },
            stop: function(event, ui) {
                var pageNum = parseInt($(this).slider('value'));
                console.log("(Slider) Stop Preview: " + pageNum);
                //$('#slider').blur();
            }
        });

//        $('#viewer-content').click(function() {
//            $('#viewer-footer').toggle();
//        });

        var swipeHandler = function(event, direction, distance, duration, fingerCount, fingerData) {
            console.log('swipe direction: ' + direction);

            var current = parseInt($('input[name=current]').val());
            var pageNum = current + (direction=='left'?1:-1);
            console.log("(Swipe) Open Page: " + pageNum);
            display(pageNum);

            $('#viewer-footer').hide();
        };

        $('#viewer-content').swipe( {
            swipeLeft: swipeHandler,
            swipeRight: swipeHandler,
            tap: function(event, target) {
                $('#viewer-footer').toggle();
            },
            threshold: 45
        });

        $('a.page-switcher').click(function () {

            var current = parseInt($('input[name=current]').val());
            var offset = parseInt($(this).data('offset'));

            current += offset;

            $('#slider').slider('value', current + 1);

            return false;
        });
    });
</script>

</body>
</html>