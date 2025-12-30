<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Shopping Mall</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <h3>My Shopping Cart</h3>
        <hr>

        <c:if test="${not empty cartList}">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th width="50">
                                <input type="checkbox" id="checkAll" onchange="checkAll()">
                            </th>
                            <th>Product Info</th>
                            <th width="150">Unit Price</th>
                            <th width="150">Quantity</th>
                            <th width="150">Subtotal</th>
                            <th width="100">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartList}" var="cart">
                            <tr>
                                <td class="text-center">
                                    <input type="checkbox" class="cart-checkbox" 
                                           data-id="${cart.id}" 
                                           ${cart.checked == 1 ? 'checked' : ''}
                                           onchange="updateChecked(${cart.id}, this.checked)">
                                </td>
                                <td>
                                    <div>
                                        <h6>${cart.productName}</h6>
                                        <small class="text-muted">Stock: ${cart.stock}</small>
                                    </div>
                                </td>
                                <td class="text-center">
                                    ¥<fmt:formatNumber value="${cart.productPrice}" pattern="#,##0.00"/>
                                </td>
                                <td class="text-center">
                                    <div class="input-group" style="width: 120px; margin: 0 auto;">
                                        <div class="input-group-prepend">
                                            <button class="btn btn-sm btn-outline-secondary" 
                                                    onclick="updateQuantity(${cart.id}, ${cart.quantity - 1})">-</button>
                                        </div>
                                        <input type="number" class="form-control form-control-sm text-center" 
                                               value="${cart.quantity}" 
                                               min="1" 
                                               max="${cart.stock}"
                                               onchange="updateQuantity(${cart.id}, this.value)">
                                        <div class="input-group-append">
                                            <button class="btn btn-sm btn-outline-secondary" 
                                                    onclick="updateQuantity(${cart.id}, ${cart.quantity + 1})">+</button>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-center text-danger font-weight-bold">
                                    ¥<fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0.00"/>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-danger" onclick="deleteCart(${cart.id})">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="row mt-3">
                <div class="col-md-6">
                    <button class="btn btn-outline-danger" onclick="deleteSelected()">
                        <i class="fas fa-trash"></i> Delete Selected
                    </button>
                </div>
                <div class="col-md-6 text-right">
                    <h5>
                        Selected <span id="selectedCount">0</span> items,
                        Total: <span class="text-danger" id="totalPrice">¥0.00</span>
                    </h5>
                    <button class="btn btn-primary btn-lg" onclick="checkout()">
                        Checkout
                    </button>
                </div>
            </div>
        </c:if>

        <c:if test="${empty cartList}">
            <div class="alert alert-info text-center">
                <h5>Your cart is empty</h5>
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
        $(document).ready(function() {
            calculateTotal();
        });

        function checkAll() {
            var checked = $('#checkAll').prop('checked');
            $('.cart-checkbox').prop('checked', checked);
            
            $.post('${pageContext.request.contextPath}/cart/updateAllChecked', {
                checked: checked ? 1 : 0
            }, function(result) {
                if (result.code === 200) {
                    calculateTotal();
                }
            });
        }

        function updateChecked(cartId, checked) {
            $.post('${pageContext.request.contextPath}/cart/updateChecked', {
                cartId: cartId,
                checked: checked ? 1 : 0
            }, function(result) {
                if (result.code === 200) {
                    calculateTotal();
                } else {
                    alert(result.message);
                }
            });
        }

        function updateQuantity(cartId, quantity) {
            if (quantity < 1) return;
            
            $.post('${pageContext.request.contextPath}/cart/updateQuantity', {
                cartId: cartId,
                quantity: quantity
            }, function(result) {
                if (result.code === 200) {
                    location.reload();
                } else {
                    alert(result.message);
                }
            });
        }

        function deleteCart(cartId) {
            if (confirm('Are you sure you want to delete this item?')) {
                $.post('${pageContext.request.contextPath}/cart/delete', {
                    cartId: cartId
                }, function(result) {
                    if (result.code === 200) {
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                });
            }
        }

        function deleteSelected() {
            var cartIds = [];
            $('.cart-checkbox:checked').each(function() {
                cartIds.push($(this).data('id'));
            });

            if (cartIds.length === 0) {
                alert('Please select items to delete');
                return;
            }

            if (confirm('Are you sure you want to delete selected items?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/cart/deleteSelected',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(cartIds),
                    success: function(result) {
                        if (result.code === 200) {
                            location.reload();
                        } else {
                            alert(result.message);
                        }
                    }
                });
            }
        }

        function calculateTotal() {
            var count = 0;
            var total = 0;

            $('.cart-checkbox:checked').each(function() {
                var row = $(this).closest('tr');
                var price = parseFloat(row.find('td:eq(2)').text().replace('¥', '').replace(',', ''));
                var quantity = parseInt(row.find('input[type="number"]').val());
                count++;
                total += price * quantity;
            });

            $('#selectedCount').text(count);
            $('#totalPrice').text('¥' + total.toFixed(2));
        }

        function checkout() {
            var cartIds = [];
            $('.cart-checkbox:checked').each(function() {
                cartIds.push($(this).data('id'));
            });

            if (cartIds.length === 0) {
                alert('Please select items to checkout');
                return;
            }

            window.location.href = '${pageContext.request.contextPath}/order/confirm?cartIds=' + cartIds.join(',');
        }
    </script>
</body>
</html>
