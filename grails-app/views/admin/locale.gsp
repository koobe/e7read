<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>翻譯管理</title>
</head>

<body>

<div class="container">

    <div class="page-header">

        <div class="btn-toolbar pull-right" role="toolbar">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <g:if test="${group}">
                        Group: ${group}
                    </g:if>
                    <g:else>
                        Group
                    </g:else>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <g:each in="${groups}"><li><g:link action="locale" params="[group: it]">${it}</g:link></li></g:each>
                </ul>
            </div>
            <div class="btn-group" role="group">
                <button type="button" id="btnLocaleAdd" class="btn btn-default">
                    <i class="fa fa-plus"></i>
                    新增
                </button>
                <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
            </div>
        </div>

        <h2>翻譯管理</h2>
    </div>

    <g:form controller="admin" action="localeAdd" method="post" role="form" class="well" name="formLocaleAdd"
            style="display: none">

        <div class="form-group">
            <label for="group">Group</label>
            <g:textField name="group" class="form-control" readonly="readonly" value="${group?group:'messages'}" />
        </div>

        <div class="form-group">
            <label for="code">Code</label>
            <g:textField name="code" class="form-control" />
        </div>

        <div class="form-group">
            <label for="lang">Language</label>
            <g:select name="lang" from="${availableLocales}" optionKey="tag" optionValue="display" class="form-control" />
        </div>

        <div class="form-group">
            <label for="content">Content</label>
            <g:textField name="content" class="form-control" />
        </div>

        <button type="submit" class="btn btn-default">Submit</button>
        <button class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th>Group</th>
                <th>Code</th>
                <th>Example (en)</th>
                <th>Example (current: ${Locale.default.toLanguageTag()})</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${locales}" var="locale">
            <tr>
                <td>
                    ${locale.group}
                </td>
                <td>
                    <g:link controller="admin" action="localeUpdate" params="[group: locale.group, code: locale.code]">${locale.code}</g:link>
                </td>
                <td>
                    <g:if test="${group=='messages'}">
                        <small><g:message code="${locale.code}" locale="en" /></small>
                    </g:if>
                    <g:else>
                        <small><g:message code="${group}|${locale.code}" locale="en" /></small>
                    </g:else>
                </td>
                <td>
                    <g:if test="${group=='messages'}">
                        <small><g:message code="${locale.code}" /></small>
                    </g:if>
                    <g:else>
                        <small><g:message code="${group}|${locale.code}" /></small>
                    </g:else>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnLocaleAdd').click(function () {
            $('#formLocaleAdd').show('slow');
            $('#localeName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formLocaleAdd').hide('slow');
            return false;
        });
    });
</script>
</body>
</html>