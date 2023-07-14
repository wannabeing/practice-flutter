import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/chats/models/chat_model.dart';
import 'package:may230517/wanda/features/chats/repos/chat_repo.dart';

// String : VM이 호출시 return(제공)하는 형식
// String : VM이 받는 인자(arg) 형식
class ChatDetailViewModel extends FamilyAsyncNotifier<String, String> {
  late final ChatRepository _chatRepository;
  late final User _loginUser;

  // =============================================
  // ✅ 생성자 및 초기화 (arg: oppUID)
  // =============================================
  @override
  FutureOr<String> build(String arg) async {
    _chatRepository = ref.read(chatRepo);
    _loginUser = ref.read(authRepo).currentUser!;
    return await _chatRepository.getChatRoomID(
      loginUID: _loginUser.uid,
      oppUID: arg,
    );
  }

  // =============================================
  // 🚀 로그인유저가 채팅방에 채팅 전송 함수
  // =============================================
  Future<void> sendChat({
    required String text,
    required String oppUID,
  }) async {
    await AsyncValue.guard(() async {
      final chat = ChatTextModel(
        text: text,
        uid: _loginUser.uid,
        createdAt: DateTime.now().toString(),
      );

      await _chatRepository.updateTextCollection(
        loginUID: _loginUser.uid,
        oppUID: oppUID,
        chat: chat,
      );
    });
  }
}

// =============================================
// 🚀 채팅방 화면 Provider
// ChatDetailViewModel: provider 호출 시 접근하는 class 이름
// String: provider 호출 시 return(제공)하는 형식
// String: provider가 받는 인자(arg) 형식
// =============================================
final chatDetailProvider =
    AsyncNotifierProvider.family<ChatDetailViewModel, String, String>(
  () => ChatDetailViewModel(),
);

// =============================================
// 🚀 채팅룸 메시지 Stream Provider
// List<ChatModel>: provider 호출 시 return(제공)하는 형식
// String: provider가 받는 인자(arg) 형식
// =============================================
final chatStreamProvider =
    StreamProvider.family.autoDispose<List<ChatTextModel>, String>(
  (ref, chatDetailArg) {
    final db = FirebaseFirestore.instance;

    // ✅ 채팅룸 안에 texts 컬렉션이 변경될 때마다 List<ChatTextModel> 변환하여 return
    return db
        .collection("chatRooms")
        .doc(chatDetailArg)
        .collection("texts")
        .orderBy("createdAt")
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => ChatTextModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  },
);
