import 'package:flutter/foundation.dart';
import 'package:sunbay/network.dart';
import 'package:sunbay/post_model.dart';

class ApiProvider with ChangeNotifier {
  final String keyword;
  ApiProvider({required this.keyword});

  List<Post> posts = [];
  bool isLoading = false;

  getPostsData() async {
    isLoading = true;
    notifyListeners();
    posts = await Network(apiKey: "7330360-e350122288fab0405c64b3e9f").getData(keyword);

    isLoading = false;
    notifyListeners();

  }

}