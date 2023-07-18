package com.example.flutter_app_demo.exception.exception_handler;

import com.example.flutter_app_demo.exception.custom_exception.EmployeeNotFoundException;
import com.example.flutter_app_demo.exception.exception_model.EmployeeException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class EmployeeExceptionController {
    @ExceptionHandler
    public ResponseEntity<EmployeeException> handlerEmployeeException(EmployeeNotFoundException ex){
        EmployeeException employeeException = new EmployeeException(
                ex.getMessage(),
                HttpStatus.NOT_FOUND
        );
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(employeeException);
    }

    @ExceptionHandler
    public ResponseEntity<EmployeeException> handlerGeneralEmplException(Exception ex){
        EmployeeException employeeException = new EmployeeException(
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(employeeException);
    }
}
