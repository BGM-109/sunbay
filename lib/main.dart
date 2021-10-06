import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text;

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("SunBay"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              text = value;
            },
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                print(text);
              },
              label: const Text("Search"))
        ],
      ),
    ));
  }
}
