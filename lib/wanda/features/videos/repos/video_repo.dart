import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';

class VideoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // =============================================
  // 🚀 GET List<Video> Collection
  // =============================================
  Future<QuerySnapshot<Map<String, dynamic>>> getVideoCollections(
      {String? lastVideoIndex}) async {
    // 공통 쿼리문 (생성일 내림차순 & 2개만)
    final defaultQuery = _db
        .collection("videos")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .limit(2);

    // ✅ 1. NULL -> 맨 처음 데이터 가져오기
    if (lastVideoIndex == null) {
      return defaultQuery.get();
    }
    // ✅ 2. NOT NULL -> 맨 처음 가져온 데이터 이후 데이터 가져오기
    else {
      return defaultQuery.startAfter([lastVideoIndex]).get();
    }
  }

  // =============================================
  // 🚀 CREATE Video Collection
  // =============================================
  Future<void> addVideoCollection(VideoModel video) async {
    await _db.collection("videos").add(video.toJson());
  }

  // =============================================
  // 🚀 UPDATE Video Collection
  // =============================================

  // =============================================
  // 🚀 DELETE Video Collection
  // =============================================

  // =============================================
  // 🚀 UPLOAD VideoFILE
  // =============================================
  Future<TaskSnapshot> uploadFile({
    required File videoFile,
    required String uid,
    required String title,
  }) async {
    return await _storage.ref().child("videos/$uid/$title").putFile(videoFile);
  }

  // =============================================
  // 🚀 UPADATE LIKE Video Collection
  // =============================================
  Future<void> updateVideoLikeCollection({
    required String vid,
    required loginUID,
  }) async {
    final defaultQuery = _db.collection("likes").doc("${loginUID}000$vid");
    final likeCollection = await defaultQuery.get();

    // ❌ 좋아요 모델이 이미 존재한다면 (삭제)
    if (likeCollection.exists) {
      await defaultQuery.delete();
    }
    // ✅ 좋아요 모델이 존재하지 않는다면 (생성)
    else {
      await defaultQuery.set({
        "uid": loginUID,
        "vid": vid,
        "createdAt": DateTime.now().toString(),
      });
    }
  }
}

final videoRepo = Provider(
  (ref) => VideoRepository(),
);
