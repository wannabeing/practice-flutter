import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';

class VideoMainViewModel extends AsyncNotifier<List<VideoModel>> {
  final List<VideoModel> _list = [
    VideoModel(title: "title"),
  ];

  // =============================================
  // 🚀 사용자에게 받은 값을 모델/로컬저장소에 저장(SET) 함수
  // =============================================
  void uploadVideo(VideoModel video) async {
    // 🌈 SET Loading
    state = const AsyncValue.loading();

    // 새로운 Async Notifier 리스트<비디오모델>로 덮어쓰기
    await Future.delayed(const Duration(seconds: 3));
    state = AsyncData(
      [..._list, video],
    );
  }

  // =============================================
  // ✅ 빌드 메소드 (초기값 반환)
  // =============================================
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 3));
    return _list;
  }
}

final videoMainProvider =
    AsyncNotifierProvider<VideoMainViewModel, List<VideoModel>>(
  () => VideoMainViewModel(),
);
