class Post {
  final String? thumbnailUrl;
  final String? tags;

  Post({this.thumbnailUrl, this.tags});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      thumbnailUrl: json["webformatURL"],
      tags: json["tags"],
    );
  }
}
