// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_spring_boot_app_demo/api/api_helper.dart';
import 'package:flutter_spring_boot_app_demo/screen/create_screen.dart';

import '../model/employee.dart';
import '../widget/employee_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ApiHelper _instance;
  List<Employee> _employees = [];

  Future<void> _refresh() async {
    // print("abc");
    setState(() {});
  }

  void _delete(int id) async {
    await _instance.deleteEmployee(id).then((value) {
      if (value == 1) {
        print('Deleted successfully');
      } else {
        print('Unable to delete this employee');
      }
    });
  }

  @override
  void initState() {
    _instance = ApiHelper.instance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        // actions: [],
        title: const Text(
          'HomeScreen',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _instance.getAllEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(snapshot.data);
          _employees = snapshot.data ?? _employees;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: _employees.isEmpty
                ? const Center(
                    child: Text("No data available!"),
                  )
                : SizedBox(
                    height: double.infinity,
                    child: ListView.builder(
                        itemCount: _employees.length,
                        itemBuilder: (context, index) => EmployeeCard(
                              employee: _employees[index],
                              onDelete: () => _delete(_employees[index].id!),
                            )),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(CreateScreen.routeName)
            .then((value) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
