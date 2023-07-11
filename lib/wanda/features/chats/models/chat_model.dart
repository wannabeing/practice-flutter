class ChatModel {
  final String text;
  final String uid;
  final String createdAt;

  ChatModel({
    required this.text,
    required this.uid,
    required this.createdAt,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        uid = json["uid"],
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "uid": uid,
      "createdAt": createdAt,
    };
  }
}
