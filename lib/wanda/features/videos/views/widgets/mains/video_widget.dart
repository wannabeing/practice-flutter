import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/generated/l10n.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';
import 'package:may230517/wanda/features/videos/views/comment_main_modal.dart';
import 'package:may230517/wanda/features/videos/views/widgets/mains/video_icon_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoWidget extends ConsumerStatefulWidget {
  final int index;
  final Function onVideoFinished;
  const VideoWidget({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends ConsumerState<VideoWidget>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/goodhair.mp4");
  late final AnimationController _animationController;

  bool _isVideoPlay = true; // 비디오 실행 여부
  bool _isReadmore = false; // 비디오 상세보기 여부
  late bool _configVideoAutoplay; // 사용자 설정 비디오오토플레이 여부
  late bool _configVideoMute; // 사용자 설정 비디오뮤트 여부

  // 🚀 화면 클릭 함수
  void _onTap() {
    // 1. 비디오컨트롤러 초기화 되었는지
    if (_videoPlayerController.value.isInitialized) {
      // 2. 재생상태라면 멈추고, 멈춘상태라면 재생
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _animationController.reverse(); // upper -> lower
      } else {
        _videoPlayerController.play();
        _animationController.forward(); // lower -> upper
      }
      // 3. 비디오 실행여부 변수 상태전환
      setState(() {
        _isVideoPlay = !_isVideoPlay;
      });
    }
  }

  // 🚀 비디오 설명글 더보기 함수
  void _toggleReadmore() {
    setState(() {
      _isReadmore = !_isReadmore;
    });
  }

  // 🚀 댓글아이콘 클릭 함수
  Future<void> _onTapComment(BuildContext contexst) async {
    // 1. 비디오 일시정지
    if (_videoPlayerController.value.isPlaying) {
      _onTap();
    }
    // 2. 모달창 보여주기
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // 투명하게
      isScrollControlled: true, // 모달창의 높이 변경하기 위해
      builder: (context) {
        return const CommentMainModal();
      },
    );
    // 3. 비디오 다시 플레이
    _onTap();
  }

  // 🚀 비디오의 보이는 비율이 달라질 때마다 실행되는 함수 ⭐️⭐️⭐️
  void _visibilityChanged(VisibilityInfo info) {
    if (!mounted) return; // dispose된 controller 조작 방지

    // [1]. 화면비율이 100% && 비디오가 멈춰있는 상태 && 비디오 상태변수 true
    // 전체화면이고, 상태변수가 true이면 비디오 실행
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        _isVideoPlay) {
      _videoPlayerController.play();
    }

    // [2]. 화면비율이 0%면 비디오 멈추기
    if (info.visibleFraction == 0 &&
        _videoPlayerController.value.isPlaying &&
        _isVideoPlay) {
      _videoPlayerController.pause();
    }
  }

  // 🚀 [1]. 비디오컨트롤러 시작 함수
  Future<void> _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 비디오컨트롤러 초기화

    // 비디오컨트롤러 리스너 등록
    _videoPlayerController.addListener(() async {
      _onVideoListener();
    });

    // 비디오 오토플레이 설정 OFF시, 자동재생 X
    if (_configVideoAutoplay == false) {
      _isVideoPlay = false;
    }
    // 비디오 음소거 설정 ON시, 음소거
    if (_configVideoMute == true) {
      await _videoPlayerController.setVolume(0.0);
    }
    setState(() {});
  }

  // 🚀 [2]. 비디오컨트롤러 리스너 함수
  void _onVideoListener() {
    // 1. 비디오컨트롤러 초기화 되었는지
    if (_videoPlayerController.value.isInitialized) {
      // 2. 비디오 영상길이와 현재 영상 위치가 같은지 (영상이 끝났는지)
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        // 3. 비디오가 끝났으면 부모함수 실행
        widget.onVideoFinished();
      }
    }
  }

  // 🚀 애니메이션컨트롤러 시작 함수
  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      value: 1.5, // 애니메이션 시작시점 값
      lowerBound: 1.0, // 애니메이션 최소 값
      upperBound: 1.5, // 애니메이션 최대 값
      duration: Utils.duration300,
    );
  }

  @override
  void initState() {
    super.initState();
    // 사용자 설정값 가져오기
    _configVideoAutoplay = ref.read(settingConfigProvider).videoAutoplay;
    _configVideoMute = ref.read(settingConfigProvider).videoMute;

    _initVideoPlayer(); // 비디오컨트롤러 초기화
    _initAnimation(); // 애니메이션컨트롤러 초기화
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: (info) => _visibilityChanged(info),
      child: Stack(
        children: [
          // ✅ 영상
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          // ✅ 화면 감지
          Positioned.fill(
            child: GestureDetector(
              onTap: () => _onTap(),
            ),
          ),
          // ✅ 재생/멈춤 아이콘
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: !_isVideoPlay ? 1 : 0, // 정지아이콘 100%
                  duration: Utils.duration300,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size28,
                        vertical: Sizes.size20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(
                        _isVideoPlay
                            ? FontAwesomeIcons.play
                            : FontAwesomeIcons.pause,
                        color: Colors.white,
                        size: Sizes.size56,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ✅ 비디오 업로드 유저 정보 (id, 설명, 해시태그)
          Positioned(
            bottom: Sizes.height / 20,
            child: Container(
              width: Sizes.width,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@ID",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Sizes.size20,
                      shadows: Utils.textShadow,
                    ),
                  ),
                  Gaps.v10,
                  GestureDetector(
                    onTap: () => _toggleReadmore(),
                    child: AnimatedSize(
                      duration: Utils.duration300,
                      child: Text(
                        "설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란설명하는란",
                        overflow: _isReadmore
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                          shadows: Utils.textShadow,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v18,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "#해시태그 ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.bold,
                              shadows: Utils.textShadow,
                            ),
                          ),
                          Text(
                            "#해시태그 ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.bold,
                              shadows: Utils.textShadow,
                            ),
                          ),
                          Text(
                            "#해시태그 ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.bold,
                              shadows: Utils.textShadow,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: Sizes.width / 15,
                        foregroundImage: const NetworkImage(
                            "https://avatars.githubusercontent.com/u/79440384"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ✅ 오른쪽 위젯들
          Positioned(
            bottom: Sizes.height / 5,
            right: Sizes.width / 30,
            child: Column(
              children: [
                // 1. 좋아요
                VideoIconWidget(
                  faIconData: FontAwesomeIcons.thumbsUp,
                  dataText: S.of(context).videoLikes(1111),
                ),
                Gaps.vheight40,
                // 2. 공유하기
                const VideoIconWidget(
                  faIconData: FontAwesomeIcons.share,
                  dataText: "공유",
                ),
                Gaps.vheight40,
                // 3. 댓글
                GestureDetector(
                  onTap: () => _onTapComment(context),
                  child: VideoIconWidget(
                    faIconData: FontAwesomeIcons.book,
                    dataText: S.of(context).videoComments(999999),
                  ),
                ),
                Gaps.vheight40,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
