import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/videos/models/video_model.dart';
import 'package:may230517/wanda/features/videos/vms/video_main_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  const VideoPreviewScreen({
    super.key,
    required this.video,
    isGalleryVideo,
  }) : isGalleryVideo = isGalleryVideo ?? false;

  final XFile video;
  final bool isGalleryVideo;

  @override
  ConsumerState<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _initVideo() async {
    // 비디오컨트롤러 파일 세팅
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize(); // 비디오컨트롤러 초기화

    await _videoPlayerController.pause(); // 비디오 pause
    await _videoPlayerController.setVolume(0); // 볼륨 세팅

    setState(() {});
  }

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 비디오 실행/정지 함수
  Future<void> _onTapVideoPlayer() async {
    if (_videoPlayerController.value.isPlaying) {
      await _videoPlayerController.pause();
    } else {
      await _videoPlayerController.play();
      await _videoPlayerController.setLooping(true);
    }

    setState(() {});
  }

  // 🚀 다음 클릭 함수
  void _onNext() {
    final VideoModel video = VideoModel(title: "${DateTime.now()}");
    ref.read(videoMainProvider.notifier).uploadVideo(video);
  }

  @override
  void initState() {
    super.initState();

    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("비디오 업로드"),
      ),
      body: _videoPlayerController.value.isInitialized
          ? GestureDetector(
              onTap: () => _onUnfocusKeyboard(),
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 20,
                    vertical: Sizes.height / 40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          // ✅ 1. 영상 미리보기
                          GestureDetector(
                            onTap: () => _onTapVideoPlayer(),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: Sizes.width / 2),
                              height: Sizes.height / 4,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: VideoPlayer(
                                    _videoPlayerController,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gaps.hwidth20,
                          // ✅ 2. 동영상 제목 TextField
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              autocorrect: false,
                              decoration: InputDecoration(
                                labelText: "동영상 제목",
                                hintText: "동영상 제목 추가",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size32,
          horizontal: Sizes.size20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // ✅ 1. 휴대폰에 저장하기 (갤러리영상이면 disabled)
            IgnorePointer(
              ignoring: widget.isGalleryVideo,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  duration: Utils.duration300, // 애니메이션 지속 시간 설정
                  width: Sizes.width / 2.5,
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.height / 60,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size14),
                    // disabled
                    color: widget.isGalleryVideo ? Colors.grey.shade300 : null,
                  ),
                  child: const Text(
                    "휴대폰에 저장",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // ⭐️ 다음버튼
            GestureDetector(
              // ❓isLoading
              onTap: ref.watch(videoMainProvider).isLoading
                  ? () {}
                  : () => _onNext(),
              child: AnimatedContainer(
                duration: Utils.duration300, // 애니메이션 지속 시간 설정
                width: Sizes.width / 2.5,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size14,
                  horizontal: Sizes.size28,
                ),
                decoration: BoxDecoration(
                  // ❓isLoading
                  color: ref.watch(videoMainProvider).isLoading
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Sizes.size14),
                ),
                child: Text(
                  "다음",
                  style: TextStyle(
                    color: ref.watch(videoMainProvider).isLoading
                        ? Colors.grey.shade800
                        : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
