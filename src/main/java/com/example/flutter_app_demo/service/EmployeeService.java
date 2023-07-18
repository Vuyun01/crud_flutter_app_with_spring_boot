package com.example.flutter_app_demo.service;

import com.example.flutter_app_demo.model.Employee;

import java.util.List;
import java.util.Optional;

public interface EmployeeService {
    Employee findById(int id);
    List<Employee> showAll();

    Employee update(Employee employee,int id);
    void deleteAll();
    Employee deleteById(int id);

    Employee add(Employee employee);
}
