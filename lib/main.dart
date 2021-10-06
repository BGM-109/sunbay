import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sunbay/api_provider.dart';
import 'dart:convert' as convert;
import 'package:sunbay/second_screen.dart';

void main() async {
  runApp(ChangeNotifierProvider<ApiProvider>(
      create: (context) => ApiProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SecondScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String keyword = "iphone";
  TextEditingController controller = TextEditingController();

  Future<List<dynamic>> getData(String text) async {
    //Insert APIKEY
    var apiKey = "7330360-e350122288fab0405c64b3e9f";
    var inputText = text;
    var url =
        "https://pixabay.com/api/?key=$apiKey&q=$inputText&image_type=photo&pretty=true";
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SunBay"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                  controller: controller,
                ),
                ElevatedButton.icon(
                    icon: const Icon(Icons.search_outlined),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        setState(() {
                          keyword = controller.text;
                          controller.text = "";
                        });
                      }
                    },
                    label: const Text("Search")),
              ],
            ),
            FutureBuilder<List<dynamic>>(
                future: getData(keyword),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
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
                    return const Center(child: Text("404 Error"));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
