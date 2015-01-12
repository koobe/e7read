
var __IS_GRAILS_DEVELOPMENT_MODE = false;

var g = {};

//var ___locale = {};

$(function() {

    __IS_GRAILS_DEVELOPMENT_MODE = $('meta[name=grails-environment]').attr('content')=='development';

    /*$.ajax('/locale/messages_zh-TW.json', {
        success: function(obj) {
            ___locale = obj;

            if (__IS_GRAILS_DEVELOPMENT_MODE) {
                if (obj.lang) {
                    console.log("Locale(" + obj.lang + ") data loaded.");
                }

                // test
                console.log(g.message({code: 'group'}));
                console.log(g.message({code: 'default.blank.message', args: ['aaa', 'bbb']}));
                console.log(g.message('default.button.update.label'));
                console.log(g.message('default.updated.message', 'ccc', 'ddd'));


            }
        }
    });*/

    // test
    //console.log(g.message({code: 'group'}));
    //console.log(g.message({code: 'default.blank.message', args: ['aaa', 'bbb']}));
    //console.log(g.message('default.button.update.label'));
    //console.log(g.message('default.updated.message', 'ccc', 'ddd'));
});

/**
 * &lt;g:message code="my.message.code" /&gt;
 * http://grails.org/doc/latest/ref/Tags/message.html
 */
g.message = function() {

    var code = null;
    var args = [];

    if (arguments.length == 1) {

        if (typeof arguments[0] === 'object') {
            var config = arguments[0];

            code = config.code;

            if (config.args) {
                args = config.args;
            }
        }
        else {
            code = arguments[0];
        }

    }
    else if (arguments.length > 1) {
        code = arguments[0];

        for (var i = 1; i < arguments.length; i++) {
            args.push(arguments[i]);
        }
    }

    // nothing to translate
    if (!code) {
        return '';
    }

    if (___locale[code]) {

        var result = ___locale[code];

        if (args) {
            for (var i = 0; i < args.length; i++) {
                var arg = args[i];
                result = result.replace('{' + i + '}', arg);
            }
        }

        return result;
    }
    return code;
};