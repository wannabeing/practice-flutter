import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';

class SocialAuthViewModel extends AsyncNotifier {
  late final AuthRepository _authRepository;

  // =============================================
  // ✅ 생성자 및 초기화
  // =============================================
  @override
  FutureOr build() {
    _authRepository = ref.read(authRepo);
  }

  // =============================================
  // 🚀 signup() github 회원가입 요청 함수
  // =============================================
  Future<void> ghSignUp() async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 🚀 Firebase SignUp 요청
    state = await AsyncValue.guard(
      () async {
        return await ref.read(authRepo).signupWithGitHub();
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
