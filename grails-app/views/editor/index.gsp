<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>

    <%--<ckeditor:resources/>--%>

    <script src="//cdn.ckeditor.com/4.4.1/standard/ckeditor.js"></script>
    <script src="//cdn.ckeditor.com/4.4.1/standard/adapters/jquery.js"></script>

    <style type="text/css">
        body {
        }
    </style>
</head>
<body>

<div class="container">


    <div class="row">

        <div class="col-md-6">
            <img src="http://cdn.flipboard.com/lonelyplanet.com/31cc453533e2e9ef0aed70510d5b3bd035f1002c/original.jpg" alt="" />
        </div>

        <div class="col-md-6">

            <p>The Balkan Penin­su­la is one of the last unex­plored fron­tiers in Europe. But with a wealth of his­to­ry, end­less cul­tur­al trea­sures and great nightlife, it’s not going to be long before the region becomes the next trav­el hotspot. Major cities are acces­si­ble by plane from other parts of Europe, and once on the ground, dri­ving dis­tances are short and roads are smooth. An exten­sive bus net­work makes it pos­si­ble to do the trip by pub­lic trans­port, and two weeks will allow you to see the major cities and get a taste of life in the Balka­ns. Hot sum­mers and cold win­ters mean that the best time to go is late spring or early autumn.
            Bosnia and Hercegovina

            Sara­je­vo</p>
        </div>
    </div>

    <hr />

    <%--<ckeditor:editor name="editor" width="100%" height="400px"></ckeditor:editor>--%>

    <textarea id="editor">1234</textarea>

    <button id="btnSubmit" class="btn btn-primary">Test</button>

    <div class="row">

        <div id="inline-column1" class="col-md-6">
            <div contenteditable="true" class="cke_editable cke_editable_inline cke_contents_ltr cke_show_borders" tabindex="0" spellcheck="false" role="textbox" aria-label="RTF 編輯器, editor3" title="RTF 編輯器, editor3" aria-describedby="cke_165" style="position: relative;"><h3>Fusce vitae porttitor</h3><p><strong>Lorem ipsum dolor sit amet dolor. Duis blandit vestibulum faucibus a, tortor.</strong></p><p>Proin nunc justo felis mollis tincidunt, risus risus pede, posuere cubilia Curae, Nullam euismod, enim. Etiam nibh ultricies dolor ac dignissim erat volutpat. Vivamus fermentum <a data-cke-saved-href="http://ckeditor.com/" href="http://ckeditor.com/">nisl nulla sem in</a> metus. Maecenas wisi. Donec nec erat volutpat.</p><blockquote><p>Fusce vitae porttitor a, euismod convallis nisl, blandit risus tortor, pretium.Vehicula vitae, imperdiet vel, ornare enim vel sodales rutrum</p></blockquote><blockquote><p>Libero nunc, rhoncus ante ipsum non ipsum. Nunc eleifend pede turpis id sollicitudin fringilla. Phasellus ultrices, velit ac arcu.</p></blockquote><p>Pellentesque nunc. Donec suscipit erat. Pellentesque habitant morbi tristique ullamcorper.</p><p><s>Mauris mattis feugiat lectus nec mauris. Nullam vitae ante.</s></p></div>
        </div>

        <div id="inline-column2" class="col-md-6"  style="-epub-writing-mode: vertical-rl;">
            <div contenteditable="true" class="cke_editable cke_editable_inline cke_contents_ltr cke_show_borders" tabindex="0" spellcheck="false" role="textbox" aria-label="RTF 編輯器, editor4" title="RTF 編輯器, editor4" aria-describedby="cke_212" style="position: relative;"><h3>Integer condimentum sit amet</h3><p><strong>Aenean nonummy a, mattis varius. Cras aliquet.</strong>Praesent <a data-cke-saved-href="http://ckeditor.com/" href="http://ckeditor.com/">magna non mattis ac, rhoncus nunc</a>, rhoncus eget, cursus pulvinar mollis.</p><p>Proin id nibh. Sed eu libero posuere sed, lectus. Phasellus dui gravida gravida feugiat mattis ac, felis.</p><p>Integer condimentum sit amet, tempor elit odio, a dolor non ante at sapien. Sed ac lectus. Nulla ligula quis eleifend mi, id leo velit pede cursus arcu id nulla ac lectus. Phasellus vestibulum. Nunc viverra enim quis diam.</p></div>
            <div contenteditable="true" class="cke_editable cke_editable_inline cke_contents_ltr cke_show_borders" tabindex="0" spellcheck="false" role="textbox" aria-label="RTF 編輯器, editor5" title="RTF 編輯器, editor5" aria-describedby="cke_259" style="position: relative;"><h3>Praesent wisi accumsan sit amet nibh</h3><p>Donec ullamcorper, risus tortor, pretium porttitor. Morbi quam quis lectus non leo.</p><p>Integer faucibus scelerisque. Proin faucibus at, aliquet vulputate, odio at eros. Fusce <a data-cke-saved-href="http://ckeditor.com/" href="http://ckeditor.com/">gravida, erat vitae augue</a>. Fusce urna fringilla gravida.</p><p>In hac habitasse platea dictumst. Praesent wisi accumsan sit amet nibh. Maecenas orci luctus a, lacinia quam sem, posuere commodo, odio condimentum tempor, pede semper risus. Suspendisse pede. In hac habitasse platea dictumst. Nam sed laoreet sit amet erat. Integer.</p></div>
        </div>
    </div>

</div>



<g:javascript>


    $('#btnSubmit').click(function() {

        $('textarea#editor').ckeditor();

        console.log("test");
        console.log($('textarea#editor'));

        var data = $('textarea#editor').val();
        console.log(data);
    });

</g:javascript>

</body>
</html>