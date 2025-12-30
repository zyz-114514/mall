<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <style>
        .register-container {
            max-width: 500px;
            margin: 50px auto;
        }
        .register-card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <div class="register-container">
        <div class="card register-card">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">User Registration</h3>
                <form id="registerForm">
                    <div class="form-group">
                        <label for="username">Username *</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password *</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <input type="password" class="form-control" id="confirmPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="realName">Real Name</label>
                        <input type="text" class="form-control" id="realName" name="realName">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                    </div>
                    <div class="form-group">
                        <label for="address">Shipping Address</label>
                        <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Register</button>
                </form>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/user/login">Already have an account? Login now</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#registerForm').submit(function(e) {
            e.preventDefault();
            
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();
            
            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return;
            }

            var userData = {
                username: $('#username').val(),
                password: password,
                realName: $('#realName').val(),
                email: $('#email').val(),
                phone: $('#phone').val(),
                address: $('#address').val()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/user/doRegister',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(userData),
                success: function(result) {
                    if (result.code === 200) {
                        alert('Registration successful, please login');
                        window.location.href = '${pageContext.request.contextPath}/user/login';
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('Registration failed, please try again later');
                }
            });
        });
    </script>
</body>
</html>
