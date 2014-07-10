<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>OAuth</title>
</head>
<body>

<oauth:connect provider="facebook" id="facebook-connect-link">Facebook</oauth:connect>

<pre>
Logged with facebook?
<s2o:ifLoggedInWith provider="facebook">yes</s2o:ifLoggedInWith>
<s2o:ifNotLoggedInWith provider="facebook">no</s2o:ifNotLoggedInWith>
</pre>

</body>
</html>