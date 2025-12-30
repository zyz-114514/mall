<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Order - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>Confirm Order</h3>
        <hr>

        <form id="orderForm">
            <div class="card mb-3">
                <div class="card-header">
                    <h5>Shipping Information</h5>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label>Receiver Name *</label>
                        <input type="text" class="form-control" id="receiverName" value="${user.realName}" required>
                    </div>
                    <div class="form-group">
                        <label>Contact Phone *</label>
                        <input type="text" class="form-control" id="receiverPhone" value="${user.phone}" required>
                    </div>
                    <div class="form-group">
                        <label>Shipping Address *</label>
                        <textarea class="form-control" id="receiverAddress" rows="3" required>${user.address}</textarea>
                    </div>
                </div>
            </div>

            <input type="hidden" id="cartIds" value="${cartIds}">

            <div class="text-right">
                <button type="button" class="btn btn-secondary" onclick="history.back()">Back</button>
                <button type="submit" class="btn btn-primary btn-lg">Submit Order</button>
            </div>
        </form>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#orderForm').submit(function(e) {
            e.preventDefault();

            var cartIdsStr = $('#cartIds').val();
            var cartIds = cartIdsStr.split(',').map(function(id) {
                return parseInt(id);
            });

            var orderData = {
                receiverName: $('#receiverName').val(),
                receiverPhone: $('#receiverPhone').val(),
                receiverAddress: $('#receiverAddress').val(),
                cartIds: cartIds
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/order/create',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(orderData),
                success: function(result) {
                    if (result.code === 200) {
                        alert('Order created successfully');
                        window.location.href = '${pageContext.request.contextPath}/order/list';
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('Order creation failed, please try again later');
                }
            });
        });
    </script>
</body>
</html>
