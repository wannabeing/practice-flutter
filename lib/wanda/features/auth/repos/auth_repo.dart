import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // =============================================
  // 🚀 firebase Auth 가져오기(GET) 함수
  // =============================================

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isLoggedIn => currentUser != null; // true: 로그인, false: 비로그인

  // =============================================
  // 🚀 firebase Auth 설정(SET) 함수
  // =============================================

  Future<void> signupWithPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOutWithFIrebaseAuth() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthRepository());
