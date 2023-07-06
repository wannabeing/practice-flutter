import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/vms/user_vm.dart';

class EmailAuthViewModel extends AsyncNotifier {
  late final AuthRepository _authRepository;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  @override
  FutureOr build() {
    _authRepository = ref.read(authRepo);
  }

  // =============================================
  // 🚀 signup() firebase_auth 회원가입 요청 함수
  // =============================================
  Future<void> signUp() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 사용자가 작성한 ID/PW
    final signupForm = ref.read(signupProvider);
    // 유저정보 Provider
    final userVM = ref.read(userProvider.notifier);

    // 🚀 Firebase SignUp 요청
    state = await AsyncValue.guard(
      () async {
        // [REQUEST] firebase_auth에 저장된 사용자 정보
        final userCredential = await _authRepository.signupWithPassword(
          signupForm["email"],
          signupForm["pw"],
        );
        // DB에 유저모델 생성 및 저장 ✅
        if (userCredential.user != null) {
          await userVM.createUserModel(
            userCredential: userCredential,
          );
        }
      },
    );

    // ❌ Error
    if (state.hasError) {
      // 에러코드 & 에러메시지
      final errorCode = ((state.error) as FirebaseException).code.toString();

      // 에러메시지 EXPOSE
      state = AsyncValue.error(
        errorCode,
        StackTrace.current,
      );
    }
  }

  // =============================================
  // 🚀 signout() firebase_auth 로그아웃 요청 함수
  // =============================================
  Future<void> signOut() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 🚀 Firebase SignOut 요청
    state = await AsyncValue.guard(
      () async {
        await _authRepository.signOutWithFIrebaseAuth();
      },
    );
  }

  // =============================================
  // 🚀 login() firebase_auth 로그인 요청 함수
  // =============================================
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 🚀 Firebase login 요청
    state = await AsyncValue.guard(
      () async {
        await _authRepository.loginWithPassword(
          email,
          password,
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

  // =============================================
  // 🚀 isValidEmail() firebase_auth 이메일 중복확인 함수
  // =============================================
  Future<void> isValidEmail(String email) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        return await _authRepository.fetchValidEmail(email);
      },
    );
  }
}

final emailAuthProvider = AsyncNotifierProvider<EmailAuthViewModel, void>(
  () => EmailAuthViewModel(),
);

// 사용자 회원가입 정보 담는 Provider
final signupProvider = StateProvider(
  (ref) => {},
);
