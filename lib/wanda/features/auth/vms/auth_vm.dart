import 'dart:async';

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
  // 🚀 signup() firebase_auth 요청 함수
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
  // 🚀 signout() firebase_auth 요청 함수
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
}

final authProvider = AsyncNotifierProvider<AuthViewModel, void>(
  () => AuthViewModel(),
);

// 사용자 회원가입 정보 담는 Provider
final signupProvider = StateProvider(
  (ref) => {},
);
