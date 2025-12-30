<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
        }
        .login-card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <div class="login-container">
        <div class="card login-card">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">User Login</h3>
                <form id="loginForm">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Login</button>
                </form>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/user/register">Don't have an account? Register now</a>
                </div>
                <div class="text-center mt-2">
                    <a href="${pageContext.request.contextPath}/">Back to Home</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#loginForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                url: '${pageContext.request.contextPath}/user/doLogin',
                type: 'POST',
                data: {
                    username: $('#username').val(),
                    password: $('#password').val()
                },
                success: function(result) {
                    if (result.code === 200) {
                        alert('Login successful');
                        window.location.href = '${pageContext.request.contextPath}/';
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('Login failed, please try again later');
                }
            });
        });
    </script>
</body>
</html>
