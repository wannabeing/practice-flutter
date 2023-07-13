import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/chats/models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // =============================================
  // 🚀 GET List<ChatList> Collection
  // =============================================
  Future<QuerySnapshot<Map<String, dynamic>>> getListChatCollection(
      {required String loginUID}) async {
    return await _db
        .collection("chatRooms")
        .where(
          Filter.or(
            Filter("firstUID", isEqualTo: loginUID),
            Filter("oppUID", isEqualTo: loginUID),
          ),
        )
        .get();
  }

  // =============================================
  // 🚀 GET ChatRoomID
  // =============================================
  Future<String> getChatRoomID({
    required String loginUID,
    required String oppUID,
  }) async {
    final loginFirst =
        (await _db.collection("chatRooms").doc("${loginUID}000$oppUID").get())
            .data();
    final oppFirst =
        (await _db.collection("chatRooms").doc("${oppUID}000$loginUID").get())
            .data();

    if (loginFirst == null && oppFirst != null) {
      return "${oppUID}000$loginUID";
    } else {
      return "${loginUID}000$oppUID";
    }
  }

  // =============================================
  // 🚀 UPDATE TEXTS Collection - texts 컬렉션에 채팅 메시지 저장
  // chatRooms/:$UID 000 $oppUID/texts/{ text, uid, createdAt }
  // =============================================
  Future<void> updateTextCollection({
    required String loginUID,
    required String oppUID,
    required ChatModel chat,
  }) async {
    dynamic query;

    // ✅ 내가 먼저 대화를 걸었는지
    final isFirstText =
        (await _db.collection("chatRooms").doc("${loginUID}000$oppUID").get())
            .data();
    // ✅ 상대방이 먼저 대화를 걸었는지
    final isOppText =
        (await _db.collection("chatRooms").doc("${oppUID}000$loginUID").get())
            .data();

    // ✅ 1-1. 둘 관계에 내가 먼저 대화를 걸었을 경우 (첫 대화시작)
    if (isFirstText == null && isOppText == null) {
      await _db.collection("chatRooms").doc("${loginUID}000$oppUID").set({
        "firstUID": loginUID,
        "oppUID": oppUID,
      });

      query = _db.collection("chatRooms").doc("${loginUID}000$oppUID");
    }
    // ✅ 1-2. 둘 관계에 내가 먼저 대화를 걸었을 경우
    if (isFirstText != null && isOppText == null) {
      query = _db.collection("chatRooms").doc("${loginUID}000$oppUID");
    }
    // ✅ 2. 둘 관계에서 상대방이 먼저 대화를 걸었을 경우
    if (isFirstText == null && isOppText != null) {
      query = _db.collection("chatRooms").doc("${oppUID}000$loginUID");
    }

    // ✅ 대화컬렉션 추가
    await query.collection("texts").add(
          chat.toJson(),
        );
  }
}

final chatRepo = Provider((ref) => ChatRepository());
