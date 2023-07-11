import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

// void : VM이 호출시 return(제공)하는 형식
// String : VM이 받는 인자(arg) 형식
class VideoInfoViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepository _videoRepository;
  late final String _vid; // 비디오 id
  late final String _loginUID; // 로그인유저 id

  @override
  FutureOr<void> build(String arg) async {
    _videoRepository = VideoRepository();
    _vid = arg;
    _loginUID = ref.read(authRepo).currentUser!.uid;
  }

  // =============================================
  // 🚀 GET 로그인사용자가 비디오 좋아요 누른 여부 함수
  // =============================================
  Future<bool> getIsLikeVideo() async {
    // 로그인 사용자가 해당 비디오 좋아요 누른 여부
    final result = await _videoRepository.getVideoLikeCollection(
        vid: _vid, uid: _loginUID);
    return result;
  }

  // =============================================
  // 🚀 UPDATE 좋아요 컬렉션 생성 함수
  // =============================================
  Future<void> setLikeVideo() async {
    await _videoRepository.updateVideoLikeCollection(
      vid: _vid,
      loginUID: ref.read(authRepo).currentUser!.uid,
    );
  }
}

// VideoIconModel: provider 호출 시 접근하는 class 이름
// void: provider 호출 시 return(제공)하는 형식
// String: provider가 받는 인자(arg) 형식
final videoInfoProvider =
    AsyncNotifierProvider.family<VideoInfoViewModel, void, String>(
  () => VideoInfoViewModel(),
);
