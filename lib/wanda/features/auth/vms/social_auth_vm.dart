import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/vms/user_vm.dart';

class SocialAuthViewModel extends AsyncNotifier {
  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  @override
  FutureOr build() {}

  // =============================================
  // 🚀 github 회원가입/로그인 요청 함수
  // =============================================
  Future<void> githubSignup() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 🚀 Firebase SignUp 요청
    state = await AsyncValue.guard(
      () async {
        // 유저정보 Provider
        final userVM = ref.read(userProvider.notifier);

        // [REQUEST] firebase_auth에 저장된 사용자 정보
        final userCredential = await ref.read(authRepo).loginWithGithub();

        // ✅ DB에 유저모델 생성 및 저장
        if (userCredential.user != null) {
          await userVM.createUserModel(
            userCredential: userCredential,
            socialAuth: true,
          );
        }
      },
    );

    // ❌ Error
    if (state.hasError) {
      // 에러코드 & 에러메시지
      // https://firebase.google.com/docs/reference/js/v8/firebase.auth.Auth#signinwithemailandpassword
      final errorCode = ((state.error) as FirebaseException).code.toString();

      // 에러메시지 EXPOSE
      state = AsyncValue.error(
        errorCode,
        StackTrace.current,
      );
    }
  }

  // =============================================
  // 🚀 google 회원가입/로그인 요청 함수
  // =============================================
  Future<void> googleSignup() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 🚀 Firebase SignUp/Login 요청
    state = await AsyncValue.guard(
      () async {
        // 유저정보 Provider
        final userVM = ref.read(userProvider.notifier);

        // [REQUEST] firebase_auth에 저장된 사용자 정보
        final userCredential = await ref.read(authRepo).loginWithGoogle();

        // ✅ DB에 유저모델 생성 및 저장
        await userVM.createUserModel(
          userCredential: userCredential,
          socialAuth: true,
        );
      },
    );

    // ❌ Error
    if (state.hasError) {
      // 에러코드 & 에러메시지
      // https://firebase.google.com/docs/reference/js/v8/firebase.auth.Auth#signinwithemailandpassword
      final errorCode = ((state.error) as FirebaseException).code.toString();

      // 에러메시지 EXPOSE
      state = AsyncValue.error(
        errorCode,
        StackTrace.current,
      );
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
