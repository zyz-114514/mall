<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management - Admin Panel</title>
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                        <i class="fas fa-users"></i> User Management
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/product/list">
                        <i class="fas fa-box"></i> Product Management
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">
                        <i class="fas fa-shopping-cart"></i> Order Management
                    </a>
                </nav>
            </div>
            
            <div class="col-md-10 admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-box"></i> Product Management</h3>
                    <div>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addProductModal">
                            <i class="fas fa-plus"></i> Add Product
                        </button>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">

        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Subtitle</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Category ID</th>
                        <th>Status</th>
                        <th>Created Time</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${productList}" var="product">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.subtitle}</td>
                            <td class="text-danger">¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                            <td>${product.stock}</td>
                            <td>${product.categoryId}</td>
                            <td>
                                <span class="badge badge-${product.status == 1 ? 'success' : 'secondary'}">
                                    ${product.status == 1 ? 'Online' : 'Offline'}
                                </span>
                            </td>
                            <td><fmt:formatDate value="${product.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <a href="${pageContext.request.contextPath}/product/detail/${product.id}" 
                                       class="btn btn-info" target="_blank">View</a>
                                    <c:if test="${product.status == 1}">
                                        <button class="btn btn-warning" onclick="updateStatus(${product.id}, 0)">Offline</button>
                                    </c:if>
                                    <c:if test="${product.status == 0}">
                                        <button class="btn btn-success" onclick="updateStatus(${product.id}, 1)">Online</button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty productList}">
            <div class="alert alert-info text-center">No products available</div>
        </c:if>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateStatus(productId, status) {
            var statusText = status == 1 ? 'online' : 'offline';
            if (confirm('Are you sure you want to set this product ' + statusText + '?')) {
                $.post('${pageContext.request.contextPath}/admin/product/updateStatus', {
                    productId: productId,
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
