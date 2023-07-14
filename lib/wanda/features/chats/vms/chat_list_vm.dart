import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/repos/user_repo.dart';
import 'package:may230517/wanda/features/chats/models/chat_list_model.dart';

class ChatListViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;

  // =============================================
  // ✅ 생성자 빌드 메소드 (초기값 반환)
  // =============================================
  @override
  FutureOr<void> build() async {
    _userRepository = UserRepository();
  }

  // =============================================
  // 🚀 DB에서 유저모델 리스트 가져오기 (GET)
  // =============================================
  Future<List<UserModel>> getUserList() async {
    final loginUID = ref.read(authRepo).currentUser!.uid;
    // ✅ DB로 부터 가져온 List<JSON>을 List<ChatListModel>로 변환
    final fromDB = await _userRepository.getListUserCollection(loginUID);
    final users = fromDB.docs.map((doc) {
      return UserModel.fromJson(doc.data());
    });

    return users.toList();
  }
}

final chatListProvider = AsyncNotifierProvider<ChatListViewModel, void>(
  () => ChatListViewModel(),
);

// =============================================
// 🚀 나의 채팅리스트 Stream Provider
// List<ChatListModel>: provider 호출 시 return(제공)하는 형식
// =============================================
final chatListStreamProvider =
    StreamProvider.autoDispose<List<ChatListModel>>((ref) {
  final db = FirebaseFirestore.instance;
  final loginUser = ref.read(authRepo).currentUser!;

  // ✅ 나의 채팅방 컬렉션이 변경될 때마다 List<ChatListModel> 변환하여 return
  return db
      .collection("users")
      .doc(loginUser.uid)
      .collection("myChats")
      .orderBy("lastTime", descending: true)
      .limit(10)
      .snapshots()
      .map(
        (event) => event.docs.map(
          (doc) {
            return ChatListModel.fromJson(doc.data());
          },
        ).toList(),
      );
});
