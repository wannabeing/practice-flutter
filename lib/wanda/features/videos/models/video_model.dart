class VideoModel {
  final String vid;
  final String uid;
  final String title;
  final String desc;
  final String videoURL;
  final String thumbURL;
  final String createdAt;
  final int likes;
  final int comments;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  VideoModel({
    required this.vid,
    required this.uid,
    required this.title,
    required this.desc,
    required this.videoURL,
    required this.thumbURL,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });

  // =============================================
  // ✅ JSON to 비디오모델
  // =============================================
  static VideoModel fromJson(Map<String, dynamic> json) {
    return VideoModel(
      vid: json["vid"],
      uid: json["uid"],
      title: json["title"],
      desc: json["desc"],
      videoURL: json["videoURL"],
      thumbURL: json["thumbURL"],
      createdAt: json["createdAt"],
      likes: json["likes"],
      comments: json["comments"],
    );
  }

  // =============================================
  // ✅ 비디오모델 to JSON
  // =============================================
  Map<String, dynamic> toJson() {
    return {
      "vid": vid,
      "uid": uid,
      "title": title,
      "desc": desc,
      "videoURL": videoURL,
      "thumbURL": thumbURL,
      "createdAt": createdAt,
      "likes": likes,
      "comments": comments,
    };
  }
}
