import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  final String url = "https://api.github.com/users";
  late List data = [];
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sdcsfsd"),
      ),
      body: ListView(
        children: data.map((user) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    user["login"],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  subtitle: Text(
                    user["url"],
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  trailing: Text(
                    user["login"],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
