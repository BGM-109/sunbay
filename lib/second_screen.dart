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
    final provider = Provider.of<ApiProvider>(context);
    final posts = provider.posts;

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
                  }
                },
                label: const Text("Search")),
            provider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: posts.isEmpty
                        ? const [Center(child: Text("No Data"))]
                        : posts
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
                  ),
          ],
        ));
  }
}
