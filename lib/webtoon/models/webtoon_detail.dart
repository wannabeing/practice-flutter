class WebtoonDetailModel {
  String title;
  String about;
  String thumb;
  String genre;
  String age;

  WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.thumb,
    required this.genre,
    required this.age,
  });

  // json -> WebtoonDetail 변환
  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        about = json["about"],
        thumb = json["thumb"],
        genre = json["genre"],
        age = json["age"];
}
