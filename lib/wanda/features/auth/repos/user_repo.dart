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
  // 🚀 UPDATE User Collection
  // =============================================
  Future<void> updateUserCollection({
    required String uid, // 컬렉션 ID
    required Map<String, dynamic> editData, // 수정할 데이터
  }) async {
    await _db.collection("users").doc(uid).update(editData);
  }

  // =============================================
  // 🚀 DELETE User Collection
  // =============================================

  // =============================================
  // 🚀 GET User Collection
  // =============================================
  Future<Map<String, dynamic>?> getUserCollection(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  // =============================================
  // 🚀 GET List<User> Collection
  // =============================================
  Future<QuerySnapshot<Map<String, dynamic>>> getListUserCollection(
      String loginUID) async {
    // 로그인한 유저 정보 제외하고 가져오기
    final fromDB = _db
        .collection("users")
        .orderBy(
          "uid",
          descending: true,
        )
        .where("uid", isNotEqualTo: loginUID)
        .limit(5)
        .get();

    return fromDB;
  }

  // =============================================
  // 🚀 UPLOAD AvatarIMG FILE
  // =============================================
  Future<TaskSnapshot> uploadAvatarIMG(
      {required File imgFile, required String fileID}) async {
    return await _storage.ref().child("avatarIMGs/$fileID").putFile(imgFile);
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
