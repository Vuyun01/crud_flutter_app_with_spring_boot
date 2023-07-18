import 'dart:convert';

import 'package:flutter_spring_boot_app_demo/api/api_constant.dart';
import 'package:flutter_spring_boot_app_demo/model/employee.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static final ApiHelper _instance = ApiHelper._();

  static ApiHelper instance() => _instance;

  Future<List<Employee>?> getAllEmployees() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final extracted = json.decode(response.body) as List;
      return extracted.map((e) => Employee.fromMap(e)).toList();
    } else {
      print("Something went wrong");
    }
    print("abc");
    return null;
  }

  Future<Employee?> getEmployeeById(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return Employee.fromJson(response.body);
    } else {
      print("Something went wrong");
    }
    print("abc");
    return null;
  }

  Future<int> deleteEmployee(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      print(response.body);
      return 1;
    } 
    return 0;
  }

  Future<int> addEmployee(Employee employee) async {
    final url = Uri.parse(baseUrl);
    final body = employee.toJson(); //define body
    final header = {
      'Content-Type':
          'application/json' //define header with body type which server will process
    };

    final response = await http.post(url, body: body, headers: header);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //201 means the request has been fulfilled and the resourse will be created
      print(response.body);
      return 1;
    }
    return 0;
  }

  Future<int> updateEmployee(Employee employee, int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final body = employee.toJson(); //define body
    final header = {
      'Content-Type':
          'application/json' //define header with body type which server will process
    };

    final response = await http.put(url, body: body, headers: header);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //201 means the request has been fulfilled and the resourse will be created
      print(response.body);
      return 1;
    }
    return 0;
  }
}
