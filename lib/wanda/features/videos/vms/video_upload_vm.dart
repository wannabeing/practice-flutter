import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

class VideoUploadViewModel extends AsyncNotifier {
  late final VideoRepository _videoRepository;
  @override
  FutureOr build() {
    _videoRepository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File videoFile) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();
    // 로그인 유저의 UID & 새로운 VID
    final uid = ref.read(authRepo).currentUser!.uid;
    final vid = DateTime.now().millisecondsSinceEpoch.toString();

    state = await AsyncValue.guard(
      () async {
        // 🚀 FireStorage 저장
        final result = await _videoRepository.uploadFile(
          videoFile: videoFile,
          uid: uid,
          vid: vid,
        );

        // ✅ 성공적으로 저장 시
        if (result.metadata != null) {
          // ✅ 새로운 비디오 모델 생성
          final video = VideoModel(
            vid: vid,
            uid: uid,
            title: "title",
            desc: "desc",
            videoURL: await result.ref.getDownloadURL(),
            thumbURL: "",
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
