import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<List<dynamic>> getData() async {
    var url =
        "https://pixabay.com/api/?key=7330360-e350122288fab0405c64b3e9f&q=iphone&image_type=photo&pretty=true";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<dynamic> hits = jsonResponse["hits"];
      return hits;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    String? text;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SunBay"),
        ),
        body: ListView(
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
                  getData();
                },
                label: const Text("Search")),
            FutureBuilder<List<dynamic>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Got Error");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(
                                snapshot.data![index]["webformatURL"],
                                width: 200,
                              ),
                              Text(snapshot.data![index]["tags"]),
                            ],
                          );
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
