<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台管理 - 在线商品销售平台</title>
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
        .admin-card {
            transition: transform 0.2s;
            cursor: pointer;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .admin-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
        }
        .stat-card-2 {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border-radius: 10px;
        }
        .stat-card-3 {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 admin-sidebar">
                <nav class="nav flex-column">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/index">
                        <i class="fas fa-tachometer-alt"></i> 控制台
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/product/list">
                        <i class="fas fa-box"></i> 商品管理
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">
                        <i class="fas fa-shopping-cart"></i> 订单管理
                    </a>
                </nav>
            </div>
            
            <div class="col-md-10 admin-content">
                <div class="mb-4">
                    <h3><i class="fas fa-tachometer-alt"></i> 管理控制台</h3>
                    <p class="text-muted">欢迎，${sessionScope.user.username}！</p>
                </div>

                <!-- 统计卡片 -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-users fa-2x mb-2"></i>
                                <h4>用户管理</h4>
                                <p class="mb-0">管理系统用户</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card-2">
                            <div class="card-body text-center">
                                <i class="fas fa-box fa-2x mb-2"></i>
                                <h4>商品管理</h4>
                                <p class="mb-0">管理商品信息</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card-3">
                            <div class="card-body text-center">
                                <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                                <h4>订单管理</h4>
                                <p class="mb-0">处理用户订单</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 功能模块 -->
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card admin-card h-100" onclick="location.href='${pageContext.request.contextPath}/admin/user/list'">
                            <div class="card-body text-center">
                                <i class="fas fa-users text-primary admin-icon"></i>
                                <h5 class="card-title">用户管理</h5>
                                <p class="card-text">管理系统用户信息、权限等</p>
                                <span class="badge badge-primary">新功能</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 mb-4">
                        <div class="card admin-card h-100" onclick="location.href='${pageContext.request.contextPath}/admin/product/list'">
                            <div class="card-body text-center">
                                <i class="fas fa-box text-success admin-icon"></i>
                                <h5 class="card-title">商品管理</h5>
                                <p class="card-text">管理商品信息、价格、库存等</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 mb-4">
                        <div class="card admin-card h-100" onclick="location.href='${pageContext.request.contextPath}/admin/order/list'">
                            <div class="card-body text-center">
                                <i class="fas fa-shopping-cart text-warning admin-icon"></i>
                                <h5 class="card-title">订单管理</h5>
                                <p class="card-text">查看和处理用户订单</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 快速操作和系统信息 -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h6 class="mb-0"><i class="fas fa-bolt"></i> 快速操作</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-flex flex-wrap">
                                    <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-primary btn-sm mb-2 mr-2">
                                        <i class="fas fa-users"></i> 用户列表
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-outline-success btn-sm mb-2 mr-2">
                                        <i class="fas fa-plus"></i> 添加商品
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/order/list" class="btn btn-outline-warning btn-sm mb-2">
                                        <i class="fas fa-list"></i> 订单列表
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-info text-white">
                                <h6 class="mb-0"><i class="fas fa-info-circle"></i> 系统信息</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-2"><strong>当前用户：</strong>${sessionScope.user.realName}</p>
                                <p class="mb-2"><strong>角色：</strong><span class="badge badge-danger">管理员</span></p>
                                <p class="mb-0"><strong>当前时间：</strong><span id="currentTime"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateTime() {
            var now = new Date();
            var timeStr = now.getFullYear() + '-' + 
                         String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                         String(now.getDate()).padStart(2, '0') + ' ' + 
                         String(now.getHours()).padStart(2, '0') + ':' + 
                         String(now.getMinutes()).padStart(2, '0') + ':' + 
                         String(now.getSeconds()).padStart(2, '0');
            $('#currentTime').text(timeStr);
        }
        
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
