import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/api/api_helper.dart';
import 'package:flutter_spring_boot_app_demo/screen/edit_screen.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail';
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
          future: ApiHelper.instance().getEmployeeById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final employee = snapshot.data;
            final first_name = employee?.firstName ?? '';
            final last_name = employee?.lastName ?? '';
            final email = employee?.email ?? '';
            final phone = employee?.phone ?? 'N/A';
            final id = employee?.id ?? 0;
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 60.0,
                      backgroundImage:
                          AssetImage('assets/images/profile_placeholder.png'),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '$first_name $last_name',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'ID: #$id',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Divider(height: 32.0, color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text(
                        'Phone',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(phone),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: () => Navigator.of(context)
                                .pushNamed(EditScreen.routeName,
                                    arguments: employee)
                                .then((_) {
                              setState(() {});
                            }),
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
