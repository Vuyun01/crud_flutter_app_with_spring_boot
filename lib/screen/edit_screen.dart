import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/widget/create_form.dart';

import '../model/employee.dart';

class EditScreen extends StatelessWidget {
  static const String routeName = '/edit';
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = ModalRoute.of(context)!.settings.arguments as Employee;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Screen"),
        ),
        body: SingleChildScrollView(
            child: EmployeeForm(
          employee: employee,
          isCreated: false,
        )));
  }
}
