import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

class VideoUploadViewModel extends AsyncNotifier {
  late final VideoRepository _videoRepository;

  // =============================================
  // ✅ 생성자 빌드 메소드 (초기화)
  // =============================================
  @override
  FutureOr build() {
    _videoRepository = ref.read(videoRepo);
  }

  // =============================================
  // 🚀 업로드한 비디오로 모델/로컬저장소에 저장(SET) 함수
  // =============================================
  Future<void> uploadVideo({
    required File videoFile,
    required String title,
    required String desc,
  }) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();
    // 로그인 유저의 UID
    final uid = ref.read(authRepo).currentUser!.uid;

    state = await AsyncValue.guard(
      () async {
        // 🚀 FireStorage 저장
        final result = await _videoRepository.uploadFile(
          videoFile: videoFile,
          uid: uid,
          title: title,
        );

        // ✅ 성공적으로 저장 시
        if (result.metadata != null) {
          // ✅ 새로운 비디오 모델 생성
          final video = VideoModel(
            vid: "", // 공백으로 해야 랜덤 ID 생성
            uid: uid,
            title: title,
            desc: desc,
            videoURL: await result.ref.getDownloadURL(),
            thumbURL: "", // firebase functions에서 생성
            createdAt: DateTime.now().toString(),
            likes: 0,
            comments: 0,
          );

          // 🚀 비디오 컬렉션 생성
          await ref.read(videoRepo).addVideoCollection(video);
        }
      },
    );
  }
}

final videoUploadProvider = AsyncNotifierProvider<VideoUploadViewModel, void>(
  () => VideoUploadViewModel(),
);
