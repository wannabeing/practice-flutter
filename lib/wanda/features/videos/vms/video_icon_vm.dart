import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/videos/repos/video_repo.dart';

class VideoIconViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepository _videoRepository;
  late final String _vid; // 비디오 id

  @override
  FutureOr build(String arg) {
    _videoRepository = VideoRepository();
    _vid = arg;
  }

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
final videoIconProvider =
    AsyncNotifierProvider.family<VideoIconViewModel, void, String>(
  () => VideoIconViewModel(),
);
