import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/chats/models/chat_model.dart';
import 'package:may230517/wanda/features/chats/repos/chat_repo.dart';

class ChatDetailViewModel extends AsyncNotifier<void> {
  late final ChatRepository _chatRepository;
  late final User _loginUser;
  @override
  FutureOr<void> build() {
    _chatRepository = ref.read(chatRepo);
    _loginUser = ref.read(authRepo).currentUser!;
  }

  Future<void> sendChat({required String text, required String oppUID}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final chat = ChatModel(
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

final chatDetailProvider = AsyncNotifierProvider<ChatDetailViewModel, void>(
  () => ChatDetailViewModel(),
);
