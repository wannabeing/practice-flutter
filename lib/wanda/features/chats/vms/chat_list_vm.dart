import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/repos/user_repo.dart';
import 'package:may230517/wanda/features/chats/models/chat_list_model.dart';
import 'package:may230517/wanda/features/chats/repos/chat_repo.dart';

class ChatListViewModel extends AsyncNotifier<List<ChatListModel>> {
  late final ChatRepository _chatRepository;
  late final UserRepository _userRepository;
  final List<ChatListModel> _list = [];

  // 🚀 VM에서 사용하는 Repo에서 비디오데이터 가져오는 함수
  Future<List<ChatListModel>> _getChatList({required String loginUID}) async {
    // ✅ DB로 부터 가져온 List<JSON>을 List<VideoModel>로 변환
    final fromDB =
        await _chatRepository.getListChatCollection(loginUID: loginUID);

    final chatList = fromDB.docs.map((doc) {
      final newChatList = ChatListModel.fromJson(doc.data());

      final otherUID =
          newChatList.firstUID == loginUID ? newChatList.oppUID : loginUID;
      // final otherUser = await ref.read(userRepo).getUserCollection(otherUID);

      return ChatListModel.fromJson(doc.data());
    });

    chatList.toList();

    return chatList.toList();
  }

  // =============================================
  // ✅ 생성자 빌드 메소드 (초기값 반환)
  // =============================================
  @override
  FutureOr<List<ChatListModel>> build() async {
    _chatRepository = ChatRepository();
    _userRepository = UserRepository();

    // _list = await _getChatList();

    final test =
        await _getChatList(loginUID: ref.read(authRepo).currentUser!.uid);

    return _list;
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

final chatListProvider =
    AsyncNotifierProvider<ChatListViewModel, List<ChatListModel>>(
  () => ChatListViewModel(),
);
