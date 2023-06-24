import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/videos/views/widgets/mains/video_widget.dart';

class VideoMainScreen extends StatefulWidget {
  const VideoMainScreen({
    super.key,
    required this.videoId,
  });

  // 🌐 RouteName
  static String routeName = "/videos/:id";

  final String videoId;

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
      body: PageView.builder(
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
      ),
    );
  }
}
