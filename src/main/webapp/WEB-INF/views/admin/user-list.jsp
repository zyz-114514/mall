<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 后台管理</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .admin-sidebar {
            background: #343a40;
            min-height: calc(100vh - 56px);
            padding: 20px 0;
        }
        .admin-sidebar .nav-link {
            color: #adb5bd;
            padding: 10px 20px;
            border-radius: 0;
        }
        .admin-sidebar .nav-link:hover,
        .admin-sidebar .nav-link.active {
            color: #fff;
            background-color: #495057;
        }
        .admin-content {
            padding: 20px;
        }
        .status-badge {
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 admin-sidebar">
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/index">
                        <i class="fas fa-tachometer-alt"></i> 控制台
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/user/list">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/product/list">
                        <i class="fas fa-box"></i> 商品管理
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">
                        <i class="fas fa-shopping-cart"></i> 订单管理
                    </a>
                </nav>
            </div>
            
            <div class="col-md-10 admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-users"></i> 用户管理</h3>
                    <div>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                            <i class="fas fa-plus"></i> 添加用户
                        </button>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="thead-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>真实姓名</th>
                                        <th>邮箱</th>
                                        <th>手机号</th>
                                        <th>角色</th>
                                        <th>状态</th>
                                        <th>注册时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${userList}" var="user">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td><strong>${user.username}</strong></td>
                                            <td>${user.realName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td>
                                                <span class="badge badge-${user.role == 'ADMIN' ? 'danger' : 'primary'} status-badge">
                                                    ${user.role == 'ADMIN' ? '管理员' : '普通用户'}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge badge-${user.status == 1 ? 'success' : 'secondary'} status-badge">
                                                    ${user.status == 1 ? '正常' : '禁用'}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <button class="btn btn-info" onclick="editUser(${user.id})">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <c:if test="${user.id != sessionScope.user.id}">
                                                        <c:if test="${user.status == 1}">
                                                            <button class="btn btn-warning" onclick="updateUserStatus(${user.id}, 0)">
                                                                <i class="fas fa-ban"></i>
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${user.status == 0}">
                                                            <button class="btn btn-success" onclick="updateUserStatus(${user.id}, 1)">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <c:if test="${empty userList}">
                            <div class="alert alert-info text-center">暂无用户数据</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 添加用户模态框 -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">添加用户</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="form-group">
                            <label>用户名 *</label>
                            <input type="text" class="form-control" id="add_username" required>
                        </div>
                        <div class="form-group">
                            <label>密码 *</label>
                            <input type="password" class="form-control" id="add_password" required>
                        </div>
                        <div class="form-group">
                            <label>真实姓名</label>
                            <input type="text" class="form-control" id="add_realName">
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input type="email" class="form-control" id="add_email">
                        </div>
                        <div class="form-group">
                            <label>手机号</label>
                            <input type="text" class="form-control" id="add_phone">
                        </div>
                        <div class="form-group">
                            <label>角色</label>
                            <select class="form-control" id="add_role">
                                <option value="USER">普通用户</option>
                                <option value="ADMIN">管理员</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="addUser()">添加</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 编辑用户模态框 -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">编辑用户</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editUserForm">
                        <input type="hidden" id="edit_id">
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" class="form-control" id="edit_username" readonly>
                        </div>
                        <div class="form-group">
                            <label>真实姓名</label>
                            <input type="text" class="form-control" id="edit_realName">
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input type="email" class="form-control" id="edit_email">
                        </div>
                        <div class="form-group">
                            <label>手机号</label>
                            <input type="text" class="form-control" id="edit_phone">
                        </div>
                        <div class="form-group">
                            <label>收货地址</label>
                            <textarea class="form-control" id="edit_address" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label>角色</label>
                            <select class="form-control" id="edit_role">
                                <option value="USER">普通用户</option>
                                <option value="ADMIN">管理员</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="updateUser()">保存</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function addUser() {
            var data = {
                username: $('#add_username').val(),
                password: $('#add_password').val(),
                realName: $('#add_realName').val(),
                email: $('#add_email').val(),
                phone: $('#add_phone').val(),
                role: $('#add_role').val()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/admin/user/add',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(result) {
                    if (result.code === 200) {
                        alert('添加成功');
                        $('#addUserModal').modal('hide');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                }
            });
        }

        function editUser(userId) {
            $.get('${pageContext.request.contextPath}/admin/user/get/' + userId, function(result) {
                if (result.code === 200) {
                    var user = result.data;
                    $('#edit_id').val(user.id);
                    $('#edit_username').val(user.username);
                    $('#edit_realName').val(user.realName);
                    $('#edit_email').val(user.email);
                    $('#edit_phone').val(user.phone);
                    $('#edit_address').val(user.address);
                    $('#edit_role').val(user.role);
                    $('#editUserModal').modal('show');
                }
            });
        }

        function updateUser() {
            var data = {
                id: $('#edit_id').val(),
                realName: $('#edit_realName').val(),
                email: $('#edit_email').val(),
                phone: $('#edit_phone').val(),
                address: $('#edit_address').val(),
                role: $('#edit_role').val()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/admin/user/update',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(result) {
                    if (result.code === 200) {
                        alert('更新成功');
                        $('#editUserModal').modal('hide');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                }
            });
        }

        function updateUserStatus(userId, status) {
            var statusText = status == 1 ? '启用' : '禁用';
            if (confirm('确定要' + statusText + '该用户吗？')) {
                $.post('${pageContext.request.contextPath}/admin/user/updateStatus', {
                    userId: userId,
                    status: status
                }, function(result) {
                    if (result.code === 200) {
                        alert('更新成功');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                });
            }
        }
    </script>
</body>
</html>
