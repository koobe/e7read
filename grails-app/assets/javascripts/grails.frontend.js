
var g = {};

var ___locale = {};

$(function() {
    $.ajax('/locale/messages_zh-TW.json', {
        success: function(obj) {
            ___locale = obj;

            if (obj.lang) {
                console.log("Locale(" + obj.lang + ") data loaded.");
            }


            // test
            console.log(g.message({code: 'group'}));
            console.log(g.message({code: 'default.blank.message', args: ['aaa', 'bbb']}));
        }
    });
});

/**
 * &lt;g:message code="my.message.code" /&gt;
 * http://grails.org/doc/latest/ref/Tags/message.html
 */
g.message = function(config) {
    var code = config.code;
    var args = config.args;

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