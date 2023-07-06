class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String avatarURL;
  final String birth;
  final List<dynamic> interests;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.avatarURL,
    required this.birth,
    required this.interests,
  });

  // =============================================
  // ✅ 빈 생성자
  // =============================================
  UserModel.empty()
      : uid = "",
        email = "",
        displayName = "",
        avatarURL = "",
        birth = "",
        interests = [];

  // =============================================
  // ✅ JSON to 유저모델
  // =============================================
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      email: json["email"],
      displayName: json["displayName"],
      avatarURL: json["avatarURL"],
      birth: json["birth"],
      interests: json["interests"],
    );
  }

  // =============================================
  // ✅ 유저모델 to JSON
  // =============================================
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "avatarURL": avatarURL,
      "birth": birth,
      "interests": interests,
    };
  }

  // =============================================
  // ✅ 유저모델 복사 함수
  // =============================================
  UserModel copoyModel({
    String? uid,
    String? email,
    String? displayName,
    String? avatarURL,
    String? birth,
    List<String>? interests,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarURL: avatarURL ?? this.avatarURL,
      birth: birth ?? this.birth,
      interests: interests ?? this.interests,
    );
  }
}
