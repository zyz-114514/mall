<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Admin Panel</title>
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
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/user/list">
                        <i class="fas fa-users"></i> User Management
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/product/list">
                        <i class="fas fa-box"></i> Product Management
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">
                        <i class="fas fa-shopping-cart"></i> Order Management
                    </a>
                </nav>
            </div>
            
            <div class="col-md-10 admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-users"></i> User Management</h3>
                    <div>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                            <i class="fas fa-plus"></i> Add User
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
                                        <th>Username</th>
                                        <th>Real Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Registration Time</th>
                                        <th>Actions</th>
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
                                                    ${user.role == 'ADMIN' ? 'Admin' : 'User'}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge badge-${user.status == 1 ? 'success' : 'secondary'} status-badge">
                                                    ${user.status == 1 ? 'Active' : 'Disabled'}
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
                            <div class="alert alert-info text-center">No user data available</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add User</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="form-group">
                            <label>Username *</label>
                            <input type="text" class="form-control" id="add_username" required>
                        </div>
                        <div class="form-group">
                            <label>Password *</label>
                            <input type="password" class="form-control" id="add_password" required>
                        </div>
                        <div class="form-group">
                            <label>Real Name</label>
                            <input type="text" class="form-control" id="add_realName">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" class="form-control" id="add_email">
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" class="form-control" id="add_phone">
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select class="form-control" id="add_role">
                                <option value="USER">User</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="addUser()">Add</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit User</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editUserForm">
                        <input type="hidden" id="edit_id">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" class="form-control" id="edit_username" readonly>
                        </div>
                        <div class="form-group">
                            <label>Real Name</label>
                            <input type="text" class="form-control" id="edit_realName">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" class="form-control" id="edit_email">
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" class="form-control" id="edit_phone">
                        </div>
                        <div class="form-group">
                            <label>Shipping Address</label>
                            <textarea class="form-control" id="edit_address" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select class="form-control" id="edit_role">
                                <option value="USER">User</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="updateUser()">Save</button>
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
                        alert('Added successfully');
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
                        alert('Updated successfully');
                        $('#editUserModal').modal('hide');
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                }
            });
        }

        function updateUserStatus(userId, status) {
            var statusText = status == 1 ? 'enable' : 'disable';
            if (confirm('Are you sure you want to ' + statusText + ' this user?')) {
                $.post('${pageContext.request.contextPath}/admin/user/updateStatus', {
                    userId: userId,
                    status: status
                }, function(result) {
                    if (result.code === 200) {
                        alert('Updated successfully');
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
