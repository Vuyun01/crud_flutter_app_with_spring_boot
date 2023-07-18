import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/api/api_helper.dart';
import 'package:flutter_spring_boot_app_demo/model/employee.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key, this.isCreated = true, this.employee});
  final bool isCreated;
  final Employee? employee;
  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();

  final Employee employee =
      Employee(firstName: '', lastName: '', email: '', phone: '');
  late final ApiHelper instance;
  @override
  void initState() {
    instance = ApiHelper.instance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onSaved: (value) {
                employee.firstName = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
              initialValue: widget.employee?.firstName ?? '',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                employee.lastName = value!;
              },
              textInputAction: TextInputAction.next,
              initialValue: widget.employee?.lastName ?? '',
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                employee.email = value!;
              },
              textInputAction: TextInputAction.next,
              initialValue: widget.employee?.email ?? '',
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                employee.phone = value!;
              },
              textInputAction: TextInputAction.done,
              initialValue: widget.employee?.phone ?? '',
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value!.isNotEmpty) {
                  if (!isValidPhone(value)) {
                    return 'Please enter a valid phone number';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            TextButton(
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.blueGrey, width: 3))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // All fields are valid, submit the form
                  _submitForm(employee);
                }
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(Employee employee) async {
    // Process the form data
    if (widget.isCreated) {
      await instance
          .addEmployee(Employee(
              firstName: employee.firstName,
              lastName: employee.lastName,
              email: employee.email,
              phone: employee.phone))
          .then((value) {
        if (value == 1) {
          print('Added successfully');
        } else {
          print('Something went wrong');
        }
      });
    } else {
      await instance
          .updateEmployee(
              Employee(
                  firstName: employee.firstName,
                  lastName: employee.lastName,
                  email: employee.email,
                  phone: employee.phone),
              widget.employee!.id!)
          .then((value) {
        if (value == 1) {
          print('Updated successfully');
        } else {
          print('Something went wrong');
        }
      }).then((value) => Navigator.of(context).pop());
    }

    // Reset the form after submission
    _formKey.currentState!.reset();
  }

  bool isValidEmail(String email) {
    // Simple email validation regex pattern
    final pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    // Simple phone number validation regex pattern
    final pattern = r'^[0-9]{10}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }
}
