class PostModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PostModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
