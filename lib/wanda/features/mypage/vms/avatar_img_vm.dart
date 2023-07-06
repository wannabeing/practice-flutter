// ignore_for_file: void_checks

import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/repos/user_repo.dart';
import 'package:may230517/wanda/features/auth/vms/user_vm.dart';

class AvatarImgViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  @override
  FutureOr<void> build() {
    _userRepository = ref.read(userRepo);
  }

  // =============================================
  // 🚀 이미지 업로드 함수
  // =============================================
  Future<void> uploadFile(File imgFile) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 로그인 유저의 UID가 fileID가 된다.
    String fileID = ref.read(authRepo).currentUser!.uid;

    state = await AsyncValue.guard(
      () async {
        // 🚀 FireStorage 저장
        final result = await _userRepository.uploadAvatarIMG(
          fileID: fileID,
          imgFile: imgFile,
        );

        // ✅ 성공적으로 저장 시
        if (result.metadata != null) {
          // 🚀 유저 컬렉션 업데이트
          await upadateUserAvatarURL();
        }
      },
    );

    // ❌ Error
    if (state.hasError) {
      // ERROR
    }
  }

  // =============================================
  // 🚀 DB 유저 아바타URL 업데이트 함수
  // =============================================
  Future<void> upadateUserAvatarURL() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    final uid = ref.read(authRepo).currentUser!.uid;
    final json = await ref.read(userRepo).getUserCollection(uid);
    final newAvatarURL = Utils.getAvatarURL(uid);

    // ✅ 수정하고자하는 유저의 데이터가 존재하다면
    if (json != null) {
      state = await AsyncValue.guard(
        () async {
          // ✅ 수정한 유저모델
          final user = UserModel.fromJson(json);
          final editUser = user.copoyModel(avatarURL: newAvatarURL);

          // ✅ userProvider state값을 갱신 (그래야 사용자단이 업데이트)
          ref.read(userProvider.notifier).state = AsyncValue.data(editUser);

          // ✅ firebase 업데이트 요청
          await _userRepository.updateUserCollection(
            uid: uid,
            editData: {"avatarURL": newAvatarURL},
          );
        },
      );

      // ❌ Error
      if (state.hasError) {
        // ERROR
      }
    } else {
      return;
    }
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarImgViewModel, void>(
  () => AvatarImgViewModel(),
);
