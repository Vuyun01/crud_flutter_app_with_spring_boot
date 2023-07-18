import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/widget/create_form.dart';

class CreateScreen extends StatelessWidget {
  static const String routeName = '/upload';
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Screen"),),
      body: const SingleChildScrollView(child: EmployeeForm())
    );
  }
}