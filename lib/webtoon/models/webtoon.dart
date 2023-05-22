class WebtoonModel {
  String id;
  String title;
  String thumb;

  WebtoonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  // json -> Webtoon 변환
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        thumb = json["thumb"];
}
