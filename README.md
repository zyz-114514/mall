# Online Shopping Mall

[![Java](https://img.shields.io/badge/Java-1.8+-orange.svg)](https://www.oracle.com/java/)
[![Spring](https://img.shields.io/badge/Spring-5.3.20-green.svg)](https://spring.io/)
[![MyBatis](https://img.shields.io/badge/MyBatis-3.5.10-red.svg)](https://mybatis.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An online shopping mall platform developed based on SSM (Spring + SpringMVC + MyBatis) framework, using agile development methodology for rapid iterative delivery.

## Project Features

- **Agile Development**: Iterative development approach, quick response to requirement changes
- **Complete Functions**: Full process including user, product, shopping cart, and order management
- **Test-Driven**: 27 unit test cases ensuring code quality
- **Standard Code**: Following Java coding standards with high code readability
- **Frontend-Backend Separation**: Clear MVC architecture, easy to maintain and extend

## Function Modules

### User Functions
- 👤 User registration/login
- 🛍️ Product browsing/searching
- 🛒 Shopping cart management
- 📦 Order creation/inquiry
- 👨‍💼 Personal information management

### Admin Functions
- 📊 Product management (CRUD)
- 📁 Category management
- 📋 Order management
- 👥 User management

## Technology Stack

### Backend Technologies
- **Core Framework**: Spring 5.3.20 + SpringMVC + MyBatis 3.5.10
- **Database**: MySQL 8.0
- **Connection Pool**: Druid 1.2.8
- **Logging**: SLF4J + Logback
- **Build Tool**: Maven 3.x

### Frontend Technologies
- JSP + JSTL
- JavaScript
- Bootstrap

### Testing Framework
- JUnit 4.13.2
- Spring Test

## Quick Start

### 1. Environment Requirements

- JDK 1.8+
- Maven 3.6+
- MySQL 8.0+
- Tomcat 9.0+

### 2. Database Initialization

```bash
# Create database and import data
mysql -u root -p < database/schema.sql
```

### 3. Configure Database

Edit `src/main/resources/jdbc.properties`:

```properties
jdbc.url=jdbc:mysql://localhost:3306/shopping_mall
jdbc.username=root
jdbc.password=your_password
```

### 4. Build and Run

```bash
# Build project
mvn clean package

# Deploy to Tomcat
# Copy target/shopping-mall.war to Tomcat's webapps directory
```

### 5. Access System

- User Portal: http://localhost:8080/shopping-mall/
- Admin Panel: http://localhost:8080/shopping-mall/admin/

**Test Accounts**:
- Regular User: user1 / user123
- Administrator: admin / admin123

## Run Tests

```bash
# Run all tests
mvn test

# Run single test class
mvn test -Dtest=UserServiceTest
```

**Test Coverage**:
- ✅ User Module: 6 test cases
- ✅ Product Module: 8 test cases
- ✅ Shopping Cart Module: 6 test cases
- ✅ Order Module: 7 test cases

## Project Structure

```
shopping-mall/
├── database/                    # Database scripts
│   └── schema.sql              # Database initialization script
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/shopping/
│   │   │       ├── controller/  # Controller layer
│   │   │       ├── service/     # Business logic layer
│   │   │       ├── mapper/      # Data access layer
│   │   │       ├── entity/      # Entity classes
│   │   │       ├── vo/          # View objects
│   │   │       ├── dto/         # Data transfer objects
│   │   │       ├── util/        # Utility classes
│   │   │       ├── exception/   # Exception handling
│   │   │       └── interceptor/ # Interceptors
│   │   ├── resources/
│   │   │   ├── spring/          # Spring configuration
│   │   │   ├── mapper/          # MyBatis mapping files
│   │   │   └── jdbc.properties  # Database configuration
│   │   └── webapp/
│   │       ├── WEB-INF/views/   # JSP pages
│   │       └── static/          # Static resources
│   └── test/
│       └── java/                # Unit tests
├── pom.xml                      # Maven configuration
└── README.md                    # Project documentation
```

## Agile Development Iterations

### Sprint 1 - Basic Architecture ✅
-  Build SSM framework
-  Configure database connection
-  Design database table structure
-  Implement basic CRUD

### Sprint 2 - Core Functions ✅
-  User registration and login
-  Product display and search
-  Shopping cart functionality
-  Order creation

### Sprint 3 - Admin Functions ✅
-  Admin backend
-  Product management
-  Order management
-  User management

### Sprint 4 - Testing and Optimization ✅
-  Write unit tests
-  Code refactoring and optimization
-  Exception handling improvement
-  Documentation writing

## Database Design

### Core Tables

- **user** - User table
- **product** - Product table
- **category** - Category table
- **cart** - Shopping cart table
- **order_info** - Order table
- **order_item** - Order item table

See `database/schema.sql` for detailed design

## Development Standards

### Code Standards
- Follow Alibaba Java Development Manual
- Use Lombok to simplify code
- Unified exception handling
- Complete code documentation

### Git Commit Standards
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation update
- `refactor`: Code refactoring
- `test`: Test related
- `chore`: Build/tool changes

## API Endpoints

### User APIs
- `POST /user/register` - User registration
- `POST /user/login` - User login
- `GET /user/logout` - User logout
- `GET /user/info` - Get user information

### Product APIs
- `GET /product/list` - Product list
- `GET /product/{id}` - Product details
- `GET /product/search` - Search products

### Shopping Cart APIs
- `POST /cart/add` - Add to cart
- `GET /cart/list` - Cart list
- `POST /cart/update` - Update cart
- `DELETE /cart/delete/{id}` - Delete cart item

### Order APIs
- `POST /order/create` - Create order
- `GET /order/list` - Order list
- `GET /order/{id}` - Order details

## Author

赵宇哲：Management Function
王嘉艺：Core Function
徐宏成：Test Optimization
孙永超：Infrastructure
