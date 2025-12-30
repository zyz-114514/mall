<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1 class="display-1">404</h1>
            <h2>Page Not Found</h2>
            <p class="lead">Sorry, the page you are looking for does not exist.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Back to Home</a>
        </div>
    </div>
</body>
</html>
