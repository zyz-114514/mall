<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - Admin Panel</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Order Management</h3>
            <a href="${pageContext.request.contextPath}/admin/index" class="btn btn-secondary">Back</a>
        </div>
        <hr>

        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>Order Number</th>
                        <th>User ID</th>
                        <th>Receiver</th>
                        <th>Phone</th>
                        <th>Order Amount</th>
                        <th>Status</th>
                        <th>Order Time</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderList}" var="order">
                        <tr>
                            <td>${order.orderNo}</td>
                            <td>${order.userId}</td>
                            <td>${order.receiverName}</td>
                            <td>${order.receiverPhone}</td>
                            <td class="text-danger">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></td>
                            <td>
                                <span class="badge badge-${order.status == 0 ? 'warning' : order.status == 4 ? 'danger' : 'success'}">
                                    ${order.statusDesc}
                                </span>
                            </td>
                            <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <button class="btn btn-info" onclick="viewOrder(${order.id})">View</button>
                                    <c:if test="${order.status == 1}">
                                        <button class="btn btn-primary" onclick="updateStatus(${order.id}, 2)">Ship</button>
                                    </c:if>
                                    <c:if test="${order.status == 2}">
                                        <button class="btn btn-success" onclick="updateStatus(${order.id}, 3)">Complete</button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty orderList}">
            <div class="alert alert-info text-center">No orders available</div>
        </c:if>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewOrder(orderId) {
            window.location.href = '${pageContext.request.contextPath}/order/detail/' + orderId;
        }

        function updateStatus(orderId, status) {
            var statusText = status == 2 ? 'ship' : 'complete';
            if (confirm('Are you sure you want to ' + statusText + ' this order?')) {
                $.post('${pageContext.request.contextPath}/admin/order/updateStatus', {
                    orderId: orderId,
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
