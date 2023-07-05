import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // =============================================
  // 🚀 CREATE User Collection
  // =============================================
  Future<void> addUserCollection(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  // =============================================
  // 🚀 UPDATE userProfile
  // =============================================
  Future<void> updateUserCollection({
    required String uid, // 컬렉션 ID
    required Map<String, dynamic> editData, // 수정할 데이터
  }) async {
    await _db.collection("users").doc(uid).update(editData);
  }

  // =============================================
  // 🚀 DELETE userProfile
  // =============================================

  // =============================================
  // 🚀 GET userProfile
  // =============================================
  Future<Map<String, dynamic>?> getUserCollection(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  // =============================================
  // 🚀 UPLOAD FILE userAvatar
  // =============================================
  Future<void> putAvatarFile(File imgFile, String fileID) async {
    await _storage.ref().child("avatarIMGs/$fileID").putFile(imgFile);
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
