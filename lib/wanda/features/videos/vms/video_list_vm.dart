import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

class VideoListViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _videoRepository; // videoRepo
  List<VideoModel> _list = []; // 이전 비디오 변수

  // 🚀 VM에서 사용하는 Repo에서 비디오데이터 가져오는 함수
  Future<List<VideoModel>> _getVideos({String? lastVideoIndex}) async {
    // ✅ DB로 부터 가져온 List<JSON>을 List<VideoModel>로 변환
    final fromDB = await _videoRepository.getListVideoCollection(
        lastVideoIndex: lastVideoIndex);
    final videos = fromDB.docs.map((doc) {
      return VideoModel.fromJson(doc.data());
    });

    return videos.toList();
  }

  // =============================================
  // ✅ 생성자 빌드 메소드 (초기값 반환)
  // =============================================
  @override
  FutureOr<List<VideoModel>> build() async {
    _videoRepository = VideoRepository();

    // ✅ _list에 가장 최근 비디오 두개 추가 및 반환
    _list = await _getVideos();
    return _list;
  }

  // =============================================
  // 🚀 초기값 videos 이후 비디오 2개 가져오기 (GET)
  // =============================================
  Future<void> getNextVideoList() async {
    // ✅ 비디오 2개 가져오기
    final nextVideos = await _getVideos(
      lastVideoIndex: _list.last.createdAt,
    );
    // ✅ View에게 [이전 비디오 + 이후 비디오] 전달
    state = AsyncValue.data([..._list, ...nextVideos]);
  }

  Future<void> refreshVideoList() async {
    // ✅ 최신 비디오 2개 가져오기
    final videos = await _getVideos();
    // ✅ 이전비디오 변수에 최신 비디오 저장
    _list = videos;
    // ✅ View에게 [ 최신 비디오 ] 리스트 전달
    state = AsyncValue.data(videos);
  }
}

final videoListProvider =
    AsyncNotifierProvider<VideoListViewModel, List<VideoModel>>(
  () => VideoListViewModel(),
);
