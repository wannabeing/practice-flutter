import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/provider_watch_widget.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';
import 'package:may230517/wanda/features/videos/views/widgets/previews/preview_text_field_widget.dart';
import 'package:may230517/wanda/features/videos/views/widgets/previews/preview_video_widget.dart';
import 'package:may230517/wanda/features/videos/vms/video_upload_vm.dart';
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
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();

  String _title = '';
  String _desc = '';

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

  // 🚀 동영상 제목 유효성 검사 함수
  String? _getTitleValid() {
    if (_title.isEmpty) return null;

    if (_title.length > 15) {
      return "10자 이하입니다.";
    }

    return null;
  }

  // 🚀 동영상 설명 유효성 검사 함수
  String? _getDescValid() {
    if (_title.isEmpty) return null;

    if (_title.length > 20) {
      return "20자 이하입니다.";
    }
    return null;
  }

  // 🚀 다음 클릭 함수
  Future<void> _onNext() async {
    // ✅ firestorage에 업로드 요청
    await ref
        .read(videoUploadProvider.notifier)
        .uploadVideo(File(widget.video.path));

    // ✅ 성공적으로 마쳤으면 메인페이지 이동
    if (mounted) {
      context.push(NavMainScreen.routeName);
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();

    _initVideo();

    _titleTextController.addListener(() {
      _title = _titleTextController.value.text;
      setState(() {});
    });
    _descTextController.addListener(() {
      _desc = _descTextController.value.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // videoUpload Provider 로딩여부
    final videoUploadLoading = ref.watch(videoUploadProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("비디오 업로드"),
      ),
      resizeToAvoidBottomInset: false,
      body: _videoPlayerController.value.isInitialized
          ? ProviderWatchWidget(
              isLoading: videoUploadLoading,
              widget: GestureDetector(
                onTap: () => _onUnfocusKeyboard(),
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width / 20,
                      vertical: Sizes.height / 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // ✅ 1. 영상 미리보기
                            PreviewVideoWidget(
                              videoPlayerController: _videoPlayerController,
                              onTap: () => _onTapVideoPlayer(),
                            ),
                            Gaps.hwidth20,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PreviewTextFieldWidget(
                                  textEditingController: _titleTextController,
                                  labelText: "동영상 제목",
                                  hintText: "동영상 제목 추가",
                                  errorText: _getTitleValid(),
                                ),
                                Gaps.vheight30,
                                PreviewTextFieldWidget(
                                  textEditingController: _descTextController,
                                  labelText: "동영상 설명",
                                  hintText: "동영상 설명 추가",
                                  errorText: _getDescValid(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
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
              onTap: !videoUploadLoading &&
                      _videoPlayerController.value.isInitialized &&
                      _title.isNotEmpty &&
                      _getTitleValid() == null &&
                      _desc.isNotEmpty &&
                      _getDescValid() == null
                  ? () => _onNext()
                  : null,
              child: AnimatedContainer(
                duration: Utils.duration300, // 애니메이션 지속 시간 설정
                width: Sizes.width / 2.5,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size14,
                  horizontal: Sizes.size28,
                ),
                decoration: BoxDecoration(
                  color: _title.isNotEmpty &&
                          _getTitleValid() == null &&
                          _desc.isNotEmpty &&
                          _getDescValid() == null
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(Sizes.size14),
                ),
                child: Text(
                  "다음",
                  style: TextStyle(
                    color: _title.isNotEmpty &&
                            _getTitleValid() == null &&
                            _desc.isNotEmpty &&
                            _getDescValid() == null
                        ? Colors.white
                        : Colors.black,
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
