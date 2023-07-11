import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/chats/models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // chatRooms/:uid000oppUID/texts/{ text, uid, createdAt }
  Future<void> updateTextCollection({
    required String loginUID,
    required String oppUID,
    required ChatModel chat,
  }) async {
    // ✅ 만약 처음 대화컬렉션 추가면 chatRoom 컬렉션에 데이터 추가
    final json =
        (await _db.collection("chatRooms").doc("${loginUID}000$oppUID").get())
            .data();
    if (json == null) {
      await _db.collection("chatRooms").doc("${loginUID}000$oppUID").set({
        "loginUID": loginUID,
        "oppUID": oppUID,
      });
    }

    // ✅ 대화컬렉션 추가
    await _db
        .collection("chatRooms")
        .doc("${loginUID}000$oppUID")
        .collection("texts")
        .add(
          chat.toJson(),
        );
  }
}

final chatRepo = Provider((ref) => ChatRepository());
