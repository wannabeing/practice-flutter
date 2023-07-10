import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/videos/views/widgets/mains/video_widget.dart';
import 'package:may230517/wanda/features/videos/vms/video_list_vm.dart';

class VideoMainScreen extends ConsumerStatefulWidget {
  const VideoMainScreen({
    super.key,
    required this.videoId,
  });

  // 🌐 RouteName
  static String routeName = "/videos/:id";

  final String videoId;

  @override
  ConsumerState<VideoMainScreen> createState() => _VideoMainScreenState();
}

class _VideoMainScreenState extends ConsumerState<VideoMainScreen> {
  final PageController _pageController = PageController();
  final _nextPageDuration = const Duration(milliseconds: 200);
  final _nextPageCurve = Curves.linear;

  // 🚀 비디오 페이지 이동 함수
  void _onPageChanged(
      {required int nextIndex, required int totalLength}) async {
    /* 
      ✅ 페이지 이동할 때, 해당 인덱스로 빠르게 이동시킨다.
    */
    _pageController.animateToPage(
      nextIndex, // videoProvider 초기값
      duration: _nextPageDuration,
      curve: _nextPageCurve,
    );

    // 다음 비디오가 마지막 비디오면 다음 비디오 2개 state에 SET
    if (nextIndex == totalLength - 1) {
      await ref.watch(videoListProvider.notifier).getNextVideoList();
    }
  }

  // 🚀 현재 비디오 끝났을 때 실행되는 함수
  void _onVideoFinished() {
    // 다음 비디오로 이동
    _pageController.nextPage(
      duration: _nextPageDuration,
      curve: _nextPageCurve,
    );
  }

  // 🚀 새로고침 함수
  Future<void> _onRefreshVideoList() async {
    return await ref.read(videoListProvider.notifier).refreshVideoList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(videoListProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text("ERROR : $error"),
          ),
          data: (videoList) {
            return Scaffold(
              resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gaps.hwidth40,
                    const FaIcon(
                      FontAwesomeIcons.playstation,
                      color: Colors.white,
                    ),
                    Gaps.h5,
                    Text(
                      "쇼츠",
                      style: TextStyle(
                        fontSize: Sizes.width / 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: CustomRefreshIndicator(
                onRefresh: _onRefreshVideoList,
                builder: (context, child, controller) {
                  return Stack(
                    children: [
                      if (!controller.isIdle)
                        Padding(
                          padding: EdgeInsets.only(top: Sizes.height / 40),
                          child: const Align(
                              alignment: Alignment.topCenter,
                              child: CircularProgressIndicator.adaptive()),
                        ),
                      child,
                    ],
                  );
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: videoList.length,
                  onPageChanged: (value) => _onPageChanged(
                    nextIndex: value,
                    totalLength: videoList.length,
                  ),
                  itemBuilder: (context, index) {
                    final video = videoList[index];

                    return VideoWidget(
                      index: index,
                      video: video,
                      onVideoFinished: () => _onVideoFinished(),
                    );
                  },
                  scrollDirection: Axis.vertical,
                ),
              ),
            );
          },
        );
  }
}
