<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理 - 后台管理</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>订单管理</h3>
            <a href="${pageContext.request.contextPath}/admin/index" class="btn btn-secondary">返回</a>
        </div>
        <hr>

        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>订单号</th>
                        <th>用户ID</th>
                        <th>收货人</th>
                        <th>联系电话</th>
                        <th>订单金额</th>
                        <th>状态</th>
                        <th>下单时间</th>
                        <th>操作</th>
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
                                    <button class="btn btn-info" onclick="viewOrder(${order.id})">查看</button>
                                    <c:if test="${order.status == 1}">
                                        <button class="btn btn-primary" onclick="updateStatus(${order.id}, 2)">发货</button>
                                    </c:if>
                                    <c:if test="${order.status == 2}">
                                        <button class="btn btn-success" onclick="updateStatus(${order.id}, 3)">完成</button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty orderList}">
            <div class="alert alert-info text-center">暂无订单</div>
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
            var statusText = status == 2 ? '发货' : '完成';
            if (confirm('确定要将订单状态更新为' + statusText + '吗？')) {
                $.post('${pageContext.request.contextPath}/admin/order/updateStatus', {
                    orderId: orderId,
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
