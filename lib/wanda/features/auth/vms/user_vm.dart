import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/repos/user_repo.dart';
import 'package:may230517/wanda/features/auth/vms/email_auth_vm.dart';

class UserViewModel extends AsyncNotifier<UserModel> {
  late final UserRepository _userRepository;
  late final AuthRepository _authRepository;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  @override
  FutureOr<UserModel> build() async {
    // repo 초기화
    _userRepository = ref.read(userRepo);
    _authRepository = ref.read(authRepo);

    // ✅ 로그인 되어있다면 UserModel 초기화
    if (_authRepository.isLoggedIn) {
      // 유저 정보 (JSON)
      final userProfile = await _userRepository.getUserCollection(
        _authRepository.currentUser!.uid,
      );
      // UserModel 반환
      if (userProfile != null) {
        return UserModel.fromJson(userProfile);
      }
    }

    return UserModel.empty();
  }

  // =============================================
  // 🚀 사용자가 입력한 정보로 DB에 유저모델 생성
  // =============================================
  Future<void> createUserModel({
    required UserCredential userCredential,
    bool? socialAuth,
  }) async {
    // 소셜로그인 여부
    final isSocialAuth = socialAuth ?? false;

    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 사용자가 입력한 정보 (state)
    final signupForm = ref.read(signupProvider);

    // UserModel 생성
    final userModel = UserModel(
      uid: userCredential.user!.uid,
      email: isSocialAuth ? userCredential.user!.email : signupForm["email"],
      displayName: isSocialAuth
          ? userCredential.user!.displayName
          : signupForm["username"],
      avatarURL: isSocialAuth ? userCredential.user!.photoURL! : "",
      birth: isSocialAuth ? Utils.getTodayDate() : signupForm["birth"],
      interests: isSocialAuth ? ["empty"] : signupForm["interests"],
    );
    // Firestore에 UserModel 생성
    await _userRepository.addUserCollection(userModel);
    // state에 UserModel 저장
    state = AsyncValue.data(userModel);
  }

  Future<bool> updateUserModel({
    required String newDisplayName,
    required String newBirth,
  }) async {
    state = const AsyncValue.loading();

    final uid = ref.read(authRepo).currentUser!.uid;
    final json = await ref.read(userRepo).getUserCollection(uid);

    if (json != null) {
      // ✅ 수정한 유저모델
      final user = UserModel.fromJson(json);
      final editUser = user.copoyModel(
        displayName: newDisplayName,
        birth: newBirth,
      );

      // ✅ userProvider state값을 갱신 (그래야 사용자단이 업데이트)
      state = AsyncValue.data(editUser);

      // ✅ firebase 업데이트 요청
      await _userRepository.updateUserCollection(
        uid: uid,
        editData: {
          "displayName": newDisplayName,
          "birth": newBirth,
        },
      );
      return true;
    } else {
      return false;
    }
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserModel>(
  () => UserViewModel(),
);
