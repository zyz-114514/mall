<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Product Detail</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .product-image {
            width: 100%;
            max-height: 500px;
            object-fit: contain;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product/list">Products</a></li>
                <li class="breadcrumb-item active">${product.name}</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-md-12">
                <h2>${product.name}</h2>
                <p class="text-muted">${product.subtitle}</p>
                <hr>
                <h3 class="text-danger">¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></h3>
                <p class="mt-3">
                    <span class="badge badge-${product.stock > 0 ? 'success' : 'danger'}">
                        ${product.stock > 0 ? 'In Stock' : 'Out of Stock'}
                    </span>
                    <span class="ml-2">Stock: ${product.stock} units</span>
                </p>

                <div class="form-group mt-4">
                    <label>Quantity:</label>
                    <div class="input-group" style="width: 150px;">
                        <div class="input-group-prepend">
                            <button class="btn btn-outline-secondary" type="button" onclick="decreaseQuantity()">-</button>
                        </div>
                        <input type="number" class="form-control text-center" id="quantity" value="1" min="1" max="${product.stock}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" onclick="increaseQuantity()">+</button>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <button class="btn btn-primary btn-lg mr-2" onclick="addToCart()">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                    <a href="${pageContext.request.contextPath}/product/list" class="btn btn-outline-secondary btn-lg">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-12">
                <h4>Product Details</h4>
                <hr>
                <div class="card">
                    <div class="card-body">
                        ${product.detail}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function increaseQuantity() {
            var quantity = parseInt($('#quantity').val());
            var max = parseInt($('#quantity').attr('max'));
            if (quantity < max) {
                $('#quantity').val(quantity + 1);
            }
        }

        function decreaseQuantity() {
            var quantity = parseInt($('#quantity').val());
            if (quantity > 1) {
                $('#quantity').val(quantity - 1);
            }
        }

        function addToCart() {
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    alert('Please login first');
                    window.location.href = '${pageContext.request.contextPath}/user/login';
                </c:when>
                <c:otherwise>
                    var quantity = parseInt($('#quantity').val());
                    $.post('${pageContext.request.contextPath}/cart/add', {
                        productId: ${product.id},
                        quantity: quantity
                    }, function(result) {
                        if (result.code === 200) {
                            if (confirm('Added successfully! Go to cart?')) {
                                window.location.href = '${pageContext.request.contextPath}/cart/list';
                            }
                        } else {
                            alert(result.message);
                        }
                    });
                </c:otherwise>
            </c:choose>
        }
    </script>
</body>
</html>
