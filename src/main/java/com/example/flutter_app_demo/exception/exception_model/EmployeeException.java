package com.example.flutter_app_demo.exception.exception_model;

import org.springframework.http.HttpStatus;

import java.sql.Timestamp;
import java.util.Date;

public class EmployeeException {

    private String message;
    private HttpStatus status;
    private Timestamp timestamp;

    public EmployeeException(String message, HttpStatus status) {
        this.message = message;
        this.status = status;
        this.timestamp = new Timestamp(new Date().getTime());
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}
