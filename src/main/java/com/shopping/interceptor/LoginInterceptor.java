package com.shopping.interceptor;

import com.shopping.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            logger.warn("Unauthorized access: {}", request.getRequestURI());
            
            String requestType = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestType)) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":401,\"message\":\"Please login first\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/login");
            }
            return false;
        }

        return true;
    }
}
