<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 在线商品销售平台</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .product-card {
            transition: transform 0.2s;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
        }
        .category-badge {
            cursor: pointer;
            margin: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp"/>

    <div class="container mt-4">
        <div class="jumbotron">
            <h1 class="display-4">欢迎来到购物商城</h1>
            <p class="lead">精选优质商品，品质保证，价格实惠</p>
            <hr class="my-4">
            <p>立即开始购物之旅</p>
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/product/list" role="button">浏览商品</a>
        </div>

        <div class="mb-4">
            <h4>商品分类</h4>
            <div>
                <c:forEach items="${categories}" var="category">
                    <a href="${pageContext.request.contextPath}/product/list?categoryId=${category.id}" 
                       class="badge badge-primary badge-pill category-badge">${category.name}</a>
                </c:forEach>
            </div>
        </div>

        <h3 class="mb-4">热门商品</h3>
        <div class="row">
            <c:forEach items="${productList}" var="product" varStatus="status">
                <c:if test="${status.index < 8}">
                    <div class="col-md-3 mb-4">
                        <div class="card product-card">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text text-muted">${product.subtitle}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-danger font-weight-bold">¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                                    <span class="text-muted">库存: ${product.stock}</span>
                                </div>
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/product/detail/${product.id}" class="btn btn-sm btn-outline-primary">查看详情</a>
                                    <button class="btn btn-sm btn-primary" onclick="addToCart(${product.id})">加入购物车</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="common/footer.jsp"/>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    alert('请先登录');
                    window.location.href = '${pageContext.request.contextPath}/user/login';
                </c:when>
                <c:otherwise>
                    $.post('${pageContext.request.contextPath}/cart/add', {
                        productId: productId,
                        quantity: 1
                    }, function(result) {
                        if (result.code === 200) {
                            alert('添加成功');
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
