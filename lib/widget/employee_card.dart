import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/screen/detail_screen.dart';

import '../model/employee.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key? key,
    required this.employee,
    required this.onDelete,
  }) : super(key: key);

  final Employee employee;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.hashCode.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Delete employee'),
                  content: const Text('Do you want to delete this employee?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        'Delete',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text('Close',
                          style: Theme.of(context).textTheme.bodyMedium),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                ));
      },
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailScreen.routeName, arguments: employee.id);
          },
          leading: CircleAvatar(child: Text('${employee.id}')),
          title: Text('${employee.firstName} ${employee.lastName}'),
          subtitle: Text(employee.email),
        ),
      ),
    );
  }
}
