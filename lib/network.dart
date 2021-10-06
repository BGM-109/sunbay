import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:sunbay/post_model.dart';

class Network {
  final String apiKey;

  Network({required this.apiKey});

  Future<List<Post>> getData(String text) async {
    var inputText = text;
    var url =
        "https://pixabay.com/api/?key=$apiKey&q=$inputText&image_type=photo&pretty=true";
    var uri = Uri.parse(url);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        List<dynamic> hits = jsonResponse["hits"];
        List<Post> result = hits.map((post) => Post.fromJson(post)).toList();
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}
