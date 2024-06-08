import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intern/nextScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> listData = [];

  Future<void> _getList() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/posts");
      setState(() {
        listData = response.data;
      });
    } catch (e) {
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
      appBar: AppBar(title: Text("List Of Post")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _getList,
            child: Text("Get list"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text('Id: ${listData[index]['id'].toString()}'),
                    title: Text(
                        'User ID: ${listData[index]['userId'].toString()}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listData[index]['title']),
                        SizedBox(height: 5),
                        Text(listData[index]['body']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
              );
            },
            child: Text("Go to Next Screen"),
          ),
        ],
      ),
    );
  }
}
