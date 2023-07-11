class ChatListModel {
  final String otherUserName; // 상대 닉네임
  final String otherAvatarURL; // 상대 프로필 이미지
  final String lastText; // 마지막 대화 나눈 대화텍스트
  final String lastTime; // 마지막 대화 나눈 시간

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  ChatListModel({
    required this.otherUserName,
    required this.otherAvatarURL,
    required this.lastText,
    required this.lastTime,
  });

  // =============================================
  // ✅ 빈 생성자
  // =============================================
  ChatListModel.empty()
      : otherUserName = "",
        otherAvatarURL = "",
        lastText = "",
        lastTime = "";

  // =============================================
  // ✅ JSON to 채팅모델
  // =============================================
  static ChatListModel fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      otherUserName: json["otherUserName"],
      otherAvatarURL: json["otherAvatarURL"],
      lastText: json["lastText"],
      lastTime: json["lastTime"],
    );
  }

  // =============================================
  // ✅ 채팅모델 to JSON
  // =============================================
  Map<String, dynamic> toJson() {
    return {
      "otherUsername": otherUserName,
      "otherAvatarURL": otherAvatarURL,
      "lastText": lastText,
      "lastTime": lastTime,
    };
  }
}
