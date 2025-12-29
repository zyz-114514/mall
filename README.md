# 在线商品销售平台 (Shopping Mall)

[![Java](https://img.shields.io/badge/Java-1.8+-orange.svg)](https://www.oracle.com/java/)
[![Spring](https://img.shields.io/badge/Spring-5.3.20-green.svg)](https://spring.io/)
[![MyBatis](https://img.shields.io/badge/MyBatis-3.5.10-red.svg)](https://mybatis.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

基于SSM（Spring + SpringMVC + MyBatis）框架开发的在线商品销售平台，采用敏捷开发模式，快速迭代交付。

## 项目特点

- **敏捷开发**：采用迭代式开发，快速响应需求变化
- **完整功能**：用户、商品、购物车、订单全流程
- **测试驱动**：27个单元测试用例，保证代码质量
- **规范代码**：遵循Java编码规范，代码可读性强
- **前后分离**：清晰的MVC架构，易于维护扩展

## 功能模块

### 用户端功能
- 用户注册/登录
- 商品浏览/搜索
- 购物车管理
- 订单创建/查询
- 个人信息管理

### 管理端功能
- 商品管理（增删改查）
- 分类管理
- 订单管理
- 用户管理

## 技术栈

### 后端技术
- **核心框架**：Spring 5.3.20 + SpringMVC + MyBatis 3.5.10
- **数据库**：MySQL 8.0
- **连接池**：Druid 1.2.8
- **日志**：SLF4J + Logback
- **构建工具**：Maven 3.x

### 前端技术
- JSP + JSTL
- JavaScript
- Bootstrap

### 测试框架
- JUnit 4.13.2
- Spring Test

## 快速开始

### 1. 环境要求

- JDK 1.8+
- Maven 3.6+
- MySQL 8.0+
- Tomcat 9.0+

### 2. 数据库初始化

```bash
# 创建数据库并导入数据
mysql -u root -p < database/schema.sql
```

### 3. 配置数据库

编辑 `src/main/resources/jdbc.properties`：

```properties
jdbc.url=jdbc:mysql://localhost:3306/shopping_mall
jdbc.username=root
jdbc.password=你的密码
```

### 4. 编译运行

```bash
# 编译项目
mvn clean package

# 部署到Tomcat
# 将target/shopping-mall.war复制到Tomcat的webapps目录
```

### 5. 访问系统

- 用户端：http://localhost:8080/shopping-mall/
- 管理端：http://localhost:8080/shopping-mall/admin/

**测试账号**：
- 普通用户：user1 / user123
- 管理员：admin / admin123

## 运行测试

```bash
# 运行所有测试
mvn test

# 运行单个测试类
mvn test -Dtest=UserServiceTest
```

**测试覆盖**：
- 用户模块：6个测试用例
- 商品模块：8个测试用例
- 购物车模块：6个测试用例
- 订单模块：7个测试用例

## 项目结构

```
shopping-mall/
├── database/                    # 数据库脚本
│   └── schema.sql              # 数据库初始化脚本
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/shopping/
│   │   │       ├── controller/  # 控制器层
│   │   │       ├── service/     # 业务逻辑层
│   │   │       ├── mapper/      # 数据访问层
│   │   │       ├── entity/      # 实体类
│   │   │       ├── vo/          # 视图对象
│   │   │       ├── dto/         # 数据传输对象
│   │   │       ├── util/        # 工具类
│   │   │       ├── exception/   # 异常处理
│   │   │       └── interceptor/ # 拦截器
│   │   ├── resources/
│   │   │   ├── spring/          # Spring配置
│   │   │   ├── mapper/          # MyBatis映射文件
│   │   │   └── jdbc.properties  # 数据库配置
│   │   └── webapp/
│   │       ├── WEB-INF/views/   # JSP页面
│   │       └── static/          # 静态资源
│   └── test/
│       └── java/                # 单元测试
├── pom.xml                      # Maven配置
└── README.md                    # 项目说明
```

## 敏捷开发迭代

### Sprint 1 - 基础架构 
-  搭建SSM框架
-  配置数据库连接
-  设计数据库表结构
-  实现基础CRUD

### Sprint 2 - 核心功能 
-  用户注册登录
-  商品展示和搜索
-  购物车功能
-  订单创建

### Sprint 3 - 管理功能 
-  管理员后台
-  商品管理
-  订单管理
-  用户管理

### Sprint 4 - 测试优化 
-  编写单元测试
-  代码重构优化
-  异常处理完善
-  文档编写

## 数据库设计

### 核心表结构

- **user** - 用户表
- **product** - 商品表
- **category** - 分类表
- **cart** - 购物车表
- **order_info** - 订单表
- **order_item** - 订单明细表

详细设计见 `database/schema.sql`

## API接口

### 用户接口
- `POST /user/register` - 用户注册
- `POST /user/login` - 用户登录
- `GET /user/logout` - 用户登出
- `GET /user/info` - 获取用户信息

### 商品接口
- `GET /product/list` - 商品列表
- `GET /product/{id}` - 商品详情
- `GET /product/search` - 搜索商品

### 购物车接口
- `POST /cart/add` - 添加到购物车
- `GET /cart/list` - 购物车列表
- `POST /cart/update` - 更新购物车
- `DELETE /cart/delete/{id}` - 删除购物车项

### 订单接口
- `POST /order/create` - 创建订单
- `GET /order/list` - 订单列表
- `GET /order/{id}` - 订单详情

##  作者

- **赵宇哲** -
- **王嘉艺** -
- **徐宏成** -
- **孙永超** -

##  小组分工
- 赵宇哲：管理功能
- 王嘉艺：核心功能
- 徐宏成：测试优化
- 孙永超：基础架构
