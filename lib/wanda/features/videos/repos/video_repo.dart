import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';

class VideoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
}

final videoRepo = Provider(
  (ref) => VideoRepository(),
);
