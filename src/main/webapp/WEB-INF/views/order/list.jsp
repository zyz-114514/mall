<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>My Orders</h3>
        <hr>

        <c:if test="${not empty orderList}">
            <c:forEach items="${orderList}" var="order">
                <div class="card mb-3">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <strong>Order No:</strong>${order.orderNo}
                            <span class="ml-3"><strong>Order Time:</strong><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </div>
                        <div>
                            <span class="badge badge-${order.status == 0 ? 'warning' : order.status == 4 ? 'danger' : 'success'} badge-pill">
                                ${order.statusDesc}
                            </span>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${order.orderItems}" var="item">
                            <div class="row mb-2">
                                <div class="col-md-6">
                                    <h6>${item.productName}</h6>
                                    <p class="text-muted">Unit Price: ¥<fmt:formatNumber value="${item.currentPrice}" pattern="#,##0.00"/></p>
                                </div>
                                <div class="col-md-3 text-center">
                                    <p>Quantity: ${item.quantity}</p>
                                </div>
                                <div class="col-md-3 text-right">
                                    <p class="text-danger font-weight-bold">
                                        ¥<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/>
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Receiver:</strong>${order.receiverName}</p>
                                <p><strong>Phone:</strong>${order.receiverPhone}</p>
                                <p><strong>Address:</strong>${order.receiverAddress}</p>
                            </div>
                            <div class="col-md-6 text-right">
                                <h5>Total: <span class="text-danger">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></span></h5>
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/order/detail/${order.id}" class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                    <c:if test="${order.status == 0}">
                                        <button class="btn btn-sm btn-danger" onclick="cancelOrder(${order.id})">
                                            <i class="fas fa-times"></i> Cancel Order
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty orderList}">
            <div class="alert alert-info text-center">
                <h5>No orders yet</h5>
                <a href="${pageContext.request.contextPath}/product/list" class="btn btn-primary mt-3">
                    Go Shopping
                </a>
            </div>
        </c:if>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function cancelOrder(orderId) {
            if (confirm('Are you sure you want to cancel this order?')) {
                $.post('${pageContext.request.contextPath}/order/cancel/' + orderId, function(result) {
                    if (result.code === 200) {
                        alert('Order cancelled');
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
