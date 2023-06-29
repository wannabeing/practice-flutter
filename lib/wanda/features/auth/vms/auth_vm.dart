import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';

class AuthViewModel extends AsyncNotifier {
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

    // 🚀 Firebase SignUp 요청
    state = await AsyncValue.guard(
      () async {
        return await _authRepository.signupWithPassword(
          signupForm["email"],
          signupForm["pw"],
        );
      },
    );
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
        return await _authRepository.signOutWithFIrebaseAuth();
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

    // 🚀 Firebase SignIn 요청
    state = await AsyncValue.guard(
      () async {
        return await _authRepository.signInWithPassword(
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
  Future<bool> isValidEmail(String email) async {
    return await _authRepository.fetchValidEmail(email);
  }
}

final authProvider = AsyncNotifierProvider<AuthViewModel, void>(
  () => AuthViewModel(),
);

// 사용자 회원가입 정보 담는 Provider
final signupProvider = StateProvider(
  (ref) => {},
);
