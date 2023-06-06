import 'package:flutter/material.dart';
import 'package:may230517/wanda/features/videos/widgets/video_widget.dart';

class VideoMainScreen extends StatefulWidget {
  const VideoMainScreen({super.key});

  @override
  State<VideoMainScreen> createState() => _VideoMainScreenState();
}

class _VideoMainScreenState extends State<VideoMainScreen> {
  final PageController _pageController = PageController();
  final _nextPageDuration = const Duration(milliseconds: 200);
  final _nextPageCurve = Curves.linear;

  // 🚀 비디오 페이지 이동 함수
  void _onPageChanged(int index) {
    // 페이지 이동할 때, 해당 인덱스로 빠르게 이동시킨다.
    _pageController.animateToPage(
      index,
      duration: _nextPageDuration,
      curve: _nextPageCurve,
    );
  }

  // 🚀 현재 비디오 끝났을 때 실행되는 함수
  void _onVideoFinished() {
    // 다음 비디오로 이동
    _pageController.nextPage(
      duration: _nextPageDuration,
      curve: _nextPageCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 3,
      onPageChanged: (value) => _onPageChanged(value),
      itemBuilder: (context, index) {
        return VideoWidget(
          index: index,
          onVideoFinished: _onVideoFinished,
        );
      },
      scrollDirection: Axis.vertical,
    );
  }
}