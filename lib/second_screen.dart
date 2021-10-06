import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunbay/api_provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String keyword = "iphone";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<ApiProvider>(context, listen: false).getPostsData(keyword));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SunBay2"),
        ),
        body: ListView(
          children: [
            TextFormField(
              controller: controller,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.search_outlined),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    keyword = controller.text;
                    controller.text = "";
                    Provider.of<ApiProvider>(context, listen: false)
                        .getPostsData(keyword);
                    setState(() {});
                  }
                },
                label: const Text("Search")),
            _myListView()
          ],
        ));
  }

  Widget _myListView() {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    final posts = provider.posts;

    if (provider.isLoading && posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (!provider.isLoading && posts.isEmpty) {
      return const Center(child: Text("No Data"));
    } else {
      return ListView(
        shrinkWrap: true,
        primary: false,
        children: posts
            .map(
              (e) => Column(
                children: [
                  Image.network(
                    e.thumbnailUrl!,
                    width: 200,
                  ),
                  Text(e.tags!),
                ],
              ),
            )
            .toList(),
      );
    }
  }
}
