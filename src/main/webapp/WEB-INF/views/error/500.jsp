<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 - 服务器错误</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1 class="display-1">500</h1>
            <h2>服务器错误</h2>
            <p class="lead">${message}</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">返回首页</a>
        </div>
    </div>
</body>
</html>
