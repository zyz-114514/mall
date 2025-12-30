<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>Profile Management</h3>
        <hr>

        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-body">
                        <form id="profileForm">
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" class="form-control" value="${user.username}" readonly>
                            </div>
                            <div class="form-group">
                                <label>Real Name</label>
                                <input type="text" class="form-control" id="realName" value="${user.realName}">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" id="email" value="${user.email}">
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" class="form-control" id="phone" value="${user.phone}">
                            </div>
                            <div class="form-group">
                                <label>Shipping Address</label>
                                <textarea class="form-control" id="address" rows="3">${user.address}</textarea>
                            </div>
                            <hr>
                            <h5>Change Password (leave blank if not changing)</h5>
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" class="form-control" id="newPassword" placeholder="Leave blank if not changing">
                            </div>
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" placeholder="Leave blank if not changing">
                            </div>
                            <div class="text-right">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">Back</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#profileForm').submit(function(e) {
            e.preventDefault();

            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();

            if (newPassword && newPassword !== confirmPassword) {
                alert('Passwords do not match');
                return;
            }

            var data = {
                realName: $('#realName').val(),
                email: $('#email').val(),
                phone: $('#phone').val(),
                address: $('#address').val()
            };

            if (newPassword) {
                data.password = newPassword;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/user/updateProfile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(result) {
                    if (result.code === 200) {
                        alert('Update successful');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('Update failed, please try again later');
                }
            });
        });
    </script>
</body>
</html>
