class NewsSource {
  final String id;
  final String name;

  //!NEWS SOURCE CONSTRUCTOR REQUIRING ID AND NAME.
  NewsSource({required this.id, required this.name});

  //!FACTORY FUNCTION TO MAP JSON
  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(id: json["id"], name: json["name"]);
  }
}
