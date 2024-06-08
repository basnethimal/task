import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  Map<String, dynamic>? postData;

  Future<void> _getPost() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/posts/1");
      setState(() {
        postData = response.data;
      });
    } catch (e) {
      print("Error: $e"); // Print the error to console
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Cannot connect to the server."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _getPost,
            child: Text("Get Post"),
          ),
          if (postData != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text(postData!['id'].toString()),
                title: Text('User ID: ${postData!['userId']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(postData!['title']),
                    SizedBox(height: 5),
                    Text(postData!['body']),
                  ],
                ),
              ),
            )
          else
            Center(
              child: Text("No data"),
            ),
        ],
      ),
    );
  }
}
