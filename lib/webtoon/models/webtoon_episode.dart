class WebtoonEpisodeModel {
  String id;
  String title;
  String thumb;
  String rating;
  String date;

  WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.thumb,
    required this.rating,
    required this.date,
  });

  // json -> WebtoonDetail 변환
  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        thumb = json["thumb"],
        rating = json["rating"],
        date = json["date"];
}
