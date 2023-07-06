import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

class VideoViewModel extends AsyncNotifier {
  late final VideoRepository _videoRepository;

  @override
  FutureOr build() {
    _videoRepository = ref.read(videoRepo);
  }

  // =============================================
  // 🚀 사용자가 입력한 정보로 DB에 비디오모델 생성 (CREATE)
  // =============================================
  Future<void> createVideoModel(VideoModel video) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        await _videoRepository.addVideoCollection(video);
      },
    );
  }
}
