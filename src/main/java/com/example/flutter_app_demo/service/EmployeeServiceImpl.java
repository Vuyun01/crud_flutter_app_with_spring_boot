package com.example.flutter_app_demo.service;

import com.example.flutter_app_demo.dao.EmployeeDAO;
import com.example.flutter_app_demo.exception.custom_exception.EmployeeNotFoundException;
import com.example.flutter_app_demo.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeServiceImpl implements EmployeeService{
    private final EmployeeDAO employeeDAO;
    @Autowired
    public EmployeeServiceImpl(EmployeeDAO employeeDAO) {
        this.employeeDAO = employeeDAO;
    }

    public Employee findById(int id) {
        Optional<Employee> employee = employeeDAO.findById(id);
        if(employee.isPresent()){
            return employee.get();
        }else{
            throw new EmployeeNotFoundException("No result found for " + id);
        }
    }

    @Override
    public List<Employee> showAll() {
        return employeeDAO.findAll();
    }

    @Override
    public Employee update(Employee employee,int id) {
        Optional<Employee> check = employeeDAO.findById(id);
        if(check.isPresent()){
            Employee new_employee = new Employee(
                    check.get().getId(),
                    employee.getFirstName(),
                    employee.getLastName(),
                    employee.getEmail(),
                    employee.getPhone()
            );
            employeeDAO.save(new_employee);
            return new_employee;
        }else{
            throw new RuntimeException("Unable to update this record");
        }

    }

    @Override
    public void deleteAll() {
        employeeDAO.deleteAll();
    }

    @Override
    public Employee deleteById(int id) {
        Optional<Employee> employee = employeeDAO.findById(id);
        if(employee.isPresent()){
            employeeDAO.delete(employee.get());
            return employee.get();
        }else{
            throw new RuntimeException("Unable to delete this record");
        }
    }

    @Override
    public Employee add(Employee employee) {
        return employeeDAO.save(employee);
    }
}
