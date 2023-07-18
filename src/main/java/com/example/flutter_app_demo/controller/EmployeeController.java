package com.example.flutter_app_demo.controller;

import com.example.flutter_app_demo.model.Employee;
import com.example.flutter_app_demo.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "api/v1/employees")
public class EmployeeController {
    private final EmployeeService employeeService;
    @Autowired
    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @GetMapping(path = "{id}")
    public Employee findStudentById(@PathVariable int id){
        return employeeService.findById(id);
    }

    @GetMapping
    public List<Employee> showAll(){
        return employeeService.showAll();
    }

    @PutMapping(path = "{id}")
    public Employee update(@PathVariable("id") int id, @RequestBody Employee employee){
        return employeeService.update(employee, id);
    }
    @DeleteMapping
    public void deleteAll(){
        employeeService.deleteAll();
    }
    @DeleteMapping(path = "{id}")
    public Employee deleteById(@PathVariable("id") int id){
        return employeeService.deleteById(id);
    }
    @PostMapping
    public Employee add(@RequestBody Employee employee){
        return employeeService.add(employee);
    }
}
