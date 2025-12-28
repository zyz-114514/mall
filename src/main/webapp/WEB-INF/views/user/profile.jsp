<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息 - 在线商品销售平台</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>个人信息管理</h3>
        <hr>

        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-body">
                        <form id="profileForm">
                            <div class="form-group">
                                <label>用户名</label>
                                <input type="text" class="form-control" value="${user.username}" readonly>
                            </div>
                            <div class="form-group">
                                <label>真实姓名</label>
                                <input type="text" class="form-control" id="realName" value="${user.realName}">
                            </div>
                            <div class="form-group">
                                <label>邮箱</label>
                                <input type="email" class="form-control" id="email" value="${user.email}">
                            </div>
                            <div class="form-group">
                                <label>手机号</label>
                                <input type="text" class="form-control" id="phone" value="${user.phone}">
                            </div>
                            <div class="form-group">
                                <label>收货地址</label>
                                <textarea class="form-control" id="address" rows="3">${user.address}</textarea>
                            </div>
                            <hr>
                            <h5>修改密码（不修改请留空）</h5>
                            <div class="form-group">
                                <label>新密码</label>
                                <input type="password" class="form-control" id="newPassword" placeholder="不修改请留空">
                            </div>
                            <div class="form-group">
                                <label>确认新密码</label>
                                <input type="password" class="form-control" id="confirmPassword" placeholder="不修改请留空">
                            </div>
                            <div class="text-right">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">返回</button>
                                <button type="submit" class="btn btn-primary">保存修改</button>
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
                alert('两次输入的密码不一致');
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
                        alert('修改成功');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('修改失败，请稍后重试');
                }
            });
        });
    </script>
</body>
</html>
