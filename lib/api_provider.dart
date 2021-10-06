import 'package:flutter/foundation.dart';
import 'package:sunbay/network.dart';
import 'package:sunbay/post_model.dart';

class ApiProvider with ChangeNotifier {
  List<Post> posts = [];
  bool isLoading = false;

  void getPostsData(String keyword) async {
    isLoading = true;
    final items = await Network(apiKey: "7330360-e350122288fab0405c64b3e9f").getData(keyword);
    posts = [
      ...items
    ];

    isLoading = false;
    notifyListeners();
  }


}