import 'package:flutter/material.dart';
import 'package:my_pratical_project/drawer/drawer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  late String name, email, mobile, collegename;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: const Text("Signup"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10.0)),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Enter Your name";
                        }
                      },
                      decoration: const InputDecoration(labelText: "Name"),
                      onSaved: (input) => name = input!,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Enter Your email";
                        }
                      },
                      decoration: const InputDecoration(labelText: "Email"),
                      onSaved: (input) => email = input!,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mobile_friendly),
                    title: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Enter Your mobile";
                        }
                      },
                      decoration: const InputDecoration(labelText: "mobile"),
                      onSaved: (input) => mobile = input!,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.collections),
                    title: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Enter Your collegename";
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: "collegename"),
                      onSaved: (input) => collegename = input!,
                    ),
                  ),
                  ButtonTheme(
                    height: 40.0,
                    minWidth: 200.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ElevatedButton(
                      onPressed: _sendToNextScreen,
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10.0)),
                ],
              ),
            ),
          ),
        ));
  }

  _sendToNextScreen() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DraweScreen(
                    name: name,
                    email: email,
                    mobile: mobile,
                    collegename: collegename,
                  )));
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
