import 'package:flutter/material.dart';

class DraweScreen extends StatefulWidget {
  final String name, email, mobile, collegename;
  const DraweScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.mobile,
      required this.collegename});

  @override
  State<DraweScreen> createState() => _DraweScreenState();
}

class _DraweScreenState extends State<DraweScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Student information'),
      ),
      body: Form(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(50)),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(widget.name),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(widget.email),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(widget.mobile),
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: Text(widget.collegename),
              )
            ],
          ),
        ),
      ),
    );
  }
}
