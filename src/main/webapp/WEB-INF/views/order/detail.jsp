<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Detail - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>Order Detail</h3>
        <hr>

        <div class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Order Number:</strong> ${order.orderNo}</p>
                        <p><strong>Order Status:</strong>
                            <span class="badge badge-${order.status == 0 ? 'warning' : order.status == 4 ? 'danger' : 'success'}">
                                ${order.statusDesc}
                            </span>
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <p><strong>Order Time:</strong> <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                        <c:if test="${order.paymentTime != null}">
                            <p><strong>Payment Time:</strong> <fmt:formatDate value="${order.paymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <h5>Product Information</h5>
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Product</th>
                            <th width="150">Unit Price</th>
                            <th width="100">Quantity</th>
                            <th width="150">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${order.orderItems}" var="item">
                            <tr>
                                <td>
                                    <span>${item.productName}</span>
                                </td>
                                <td class="text-center">¥<fmt:formatNumber value="${item.currentPrice}" pattern="#,##0.00"/></td>
                                <td class="text-center">${item.quantity}</td>
                                <td class="text-center text-danger">¥<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <hr>

                <div class="row">
                    <div class="col-md-6">
                        <h5>Shipping Information</h5>
                        <p><strong>Receiver:</strong> ${order.receiverName}</p>
                        <p><strong>Phone:</strong> ${order.receiverPhone}</p>
                        <p><strong>Address:</strong> ${order.receiverAddress}</p>
                    </div>
                    <div class="col-md-6 text-right">
                        <h4>Total Price: <span class="text-danger">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></span></h4>
                    </div>
                </div>

                <div class="text-right mt-3">
                    <a href="${pageContext.request.contextPath}/order/list" class="btn btn-secondary">Back to Order List</a>
                    <c:if test="${order.status == 0}">
                        <button class="btn btn-danger" onclick="cancelOrder(${order.id})">Cancel Order</button>
                    </c:if>
                </div>
            </div>
        </div>
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
