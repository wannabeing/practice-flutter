import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GithubAuthProvider _githubAuthProvider = GithubAuthProvider();

  // =============================================
  // 🚀 firebase Auth 가져오기(GET) 함수
  // =============================================

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isLoggedIn => currentUser != null; // true: 로그인, false: 비로그인

  // =============================================
  // 🚀 firebase auth 이메일중복 확인
  // =============================================
  Future<bool> fetchValidEmail(String email) async {
    // 특정 이메일 주소에 대해 등록된 인증 방법을 확인하고, 인증 방법이 비어있는지 여부를 반환
    final result = await _firebaseAuth.fetchSignInMethodsForEmail(email);

    // 인증 방법이 있으면 중복된 이메일로 간주
    if (result.isNotEmpty) {
      return false;
    }
    return true;
  }

  // =============================================
  // 🚀 firebase auth 회원가입
  // =============================================
  Future<void> signupWithPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // =============================================
  // 🚀 github 회원가입
  // =============================================
  Future<void> signupWithGitHub() async {
    await _firebaseAuth.signInWithProvider(_githubAuthProvider);
  }

  // =============================================
  // 🚀 firebase auth 로그아웃
  // =============================================
  Future<void> signOutWithFIrebaseAuth() async {
    await _firebaseAuth.signOut();
  }

  // =============================================
  // 🚀 firebase auth 로그인
  // =============================================
  Future<void> loginWithPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authRepo = Provider((ref) => AuthRepository());
