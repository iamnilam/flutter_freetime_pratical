import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiNewScreen extends StatefulWidget {
  const ApiNewScreen({Key? key}) : super(key: key);

  @override
  State<ApiNewScreen> createState() => _ApiNewScreenState();
}

class _ApiNewScreenState extends State<ApiNewScreen> {
  late List userData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=50";

  Future getData() async {
    var response = await http.get(Uri.parse(url));

    setState(() {
      userData = json.decode(response.body)["results"];
      isLoading = false;
    });
    return 'Success';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App API"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: userData == null ? 0 : userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Image(
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  userData[index]["picture"]["thumbnail"]),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "User: ${userData[index]["name"]["first"] + " " + userData[index]["name"]["last"]}",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  "Phone: ${userData[index]["phone"]}",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  "Gender: ${userData[index]["gender"]}",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
