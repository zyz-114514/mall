package com.shopping.exception;

import com.shopping.util.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Result<?> handleBusinessException(BusinessException e, HttpServletRequest request) {
        logger.error("业务异常: {}, URI: {}", e.getMessage(), request.getRequestURI());
        return Result.error(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception e, HttpServletRequest request) {
        logger.error("系统异常: {}, URI: {}", e.getMessage(), request.getRequestURI(), e);
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("message", "系统异常，请稍后重试");
        mav.addObject("exception", e.getMessage());
        mav.addObject("url", request.getRequestURL());
        mav.setViewName("error/500");
        return mav;
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public Result<?> handleRuntimeException(RuntimeException e, HttpServletRequest request) {
        logger.error("运行时异常: {}, URI: {}", e.getMessage(), request.getRequestURI(), e);
        return Result.error("系统异常，请稍后重试");
    }
}
