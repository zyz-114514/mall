<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加商品 - 后台管理</title>
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
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 admin-sidebar">
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/index">
                        <i class="fas fa-tachometer-alt"></i> 控制台
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/product/list">
                        <i class="fas fa-box"></i> 商品管理
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">
                        <i class="fas fa-shopping-cart"></i> 订单管理
                    </a>
                </nav>
            </div>
            
            <div class="col-md-10 admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-plus"></i> 添加商品</h3>
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> 返回列表
                    </a>
                </div>

                <div class="card">
                    <div class="card-body">
                        <form id="productForm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>商品名称 *</label>
                                        <input type="text" class="form-control" id="name" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>商品分类 *</label>
                                        <select class="form-control" id="categoryId" required>
                                            <option value="">请选择分类</option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.id}">${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>商品副标题</label>
                                <input type="text" class="form-control" id="subtitle" placeholder="商品的简短描述">
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>价格 *</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">¥</span>
                                            </div>
                                            <input type="number" class="form-control" id="price" step="0.01" min="0" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>库存 *</label>
                                        <input type="number" class="form-control" id="stock" min="0" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>状态</label>
                                        <select class="form-control" id="status">
                                            <option value="1">上架</option>
                                            <option value="0">下架</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>商品详情</label>
                                <textarea class="form-control" id="detail" rows="6" placeholder="商品的详细描述"></textarea>
                            </div>
                            
                            <div class="text-right">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">取消</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> 保存商品
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#productForm').submit(function(e) {
            e.preventDefault();

            var data = {
                name: $('#name').val(),
                categoryId: $('#categoryId').val(),
                subtitle: $('#subtitle').val(),
                price: $('#price').val(),
                stock: $('#stock').val(),
                status: $('#status').val(),
                detail: $('#detail').val()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/admin/product/add',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(result) {
                    if (result.code === 200) {
                        alert('添加成功');
                        window.location.href = '${pageContext.request.contextPath}/admin/product/list';
                    } else {
                        alert(result.message);
                    }
                },
                error: function() {
                    alert('添加失败，请稍后重试');
                }
            });
        });
    </script>
</body>
</html>
