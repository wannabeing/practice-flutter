class ChatListModel {
  final String chatRoomID; // 채팅방 id
  final String oppUID; // 상대 uid
  final String oppDisplayname; // 상대 닉네임
  final String oppAvatarURL; // 상대 프로필 이미지
  final String lastText; // 마지막 대화 나눈 대화텍스트
  final String lastTime; // 마지막 대화 나눈 시간

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  ChatListModel({
    required this.chatRoomID,
    required this.oppUID,
    required this.oppDisplayname,
    required this.oppAvatarURL,
    required this.lastText,
    required this.lastTime,
  });

  // =============================================
  // ✅ 빈 생성자
  // =============================================
  ChatListModel.empty()
      : chatRoomID = "",
        oppUID = "",
        oppDisplayname = "",
        oppAvatarURL = "",
        lastText = "",
        lastTime = "";

  // =============================================
  // ✅ JSON to 채팅모델
  // =============================================
  static ChatListModel fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      chatRoomID: json["chatRoomID"],
      oppUID: json["oppUID"],
      oppDisplayname: json["oppDisplayname"] ?? "",
      oppAvatarURL: json["oppAvatarURL"] ?? "",
      lastText: json["lastText"],
      lastTime: json["lastTime"],
    );
  }

  // =============================================
  // ✅ 채팅모델 to JSON
  // =============================================
  Map<String, dynamic> toJson() {
    return {
      "chatRoomID": chatRoomID,
      "oppUID": oppUID,
      "oppDisplayname": oppDisplayname,
      "oppAvatarURL": oppAvatarURL,
      "lastText": lastText,
      "lastTime": lastTime,
    };
  }

  // =============================================
  // ✅ 채팅모델 덮어쓰기 함수
  // =============================================
  ChatListModel pasteModel({
    String? chatRoomID,
    String? oppUID,
    String? oppDisplayname,
    String? oppAvatarURL,
    String? lastText,
    String? lastTime,
  }) {
    return ChatListModel(
      chatRoomID: chatRoomID ?? this.chatRoomID,
      oppUID: oppUID ?? this.oppUID,
      oppDisplayname: oppDisplayname ?? this.oppDisplayname,
      oppAvatarURL: oppAvatarURL ?? this.oppAvatarURL,
      lastText: lastText ?? this.lastText,
      lastTime: lastTime ?? this.lastTime,
    );
  }
}
