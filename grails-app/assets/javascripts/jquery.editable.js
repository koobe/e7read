/**
 * Created by lyhcode on 2014/7/18.
 */

$.fn.inlineEditing = function(callback) {
    $(this).each(function() {
        //console.log($(this));
        var id = $(this).data('id');
        var field = $(this).data('field');
        var url = $(this).data('url');
        var beforeText;

        //console.log(id + ", " + field + ", " + url);

        $(this).unbind('focus').focus(function() {
            beforeText = $(this).text();
        });

        $(this).unbind('blur').blur(function() {
            if ($(this).text() != beforeText) {

                var data = {};
                data['id'] = id;
                data[field] = $(this).text();

                $.ajax({
                    type:'POST',
                    data: data,
                    url: url,
                    success: callback
                });
            }
        });

        $(this).unbind('keydown').keydown(function(event){
            if ( event.which == 13 ) {
                $(this).blur();
            }
        });
    });
};