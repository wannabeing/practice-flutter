import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/videos/video_preview_screen.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({
    super.key,
    required this.cameraController,
  });

  final CameraController cameraController;

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton>
    with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Utils.duration200,
  );
  // 부모 카메라컨트롤러
  late final CameraController _cameraController = widget.cameraController;

  // 애니메이션 (1.0 -> 0.5 크기 축소)
  late final Animation<double> _scaleAnimation = Tween(
    begin: 1.0,
    end: 0.5,
  ).animate(_animationController);

  bool _isRecording = false; // 녹화 시작 여부 (true: 녹화중)

  // 🚀 영상 녹화 시작/취소 함수
  Future<void> _onRecroding() async {
    _isRecording = !_isRecording;

    // ✅ 녹화 시작
    if (_isRecording) {
      // 녹화중이라면 return
      if (_cameraController.value.isRecordingVideo) return;
      // 비디오 녹화 start
      await _cameraController.startVideoRecording();

      // 애니메이션 start
      _animationController.forward();
    }
    // ✅ 녹화 종료
    else {
      // 녹화중이 아니라면 return
      if (!_cameraController.value.isRecordingVideo) return;
      // 애니메이션 start
      _animationController.reverse();
      // 비디오 녹화 stop
      final xFile = await _cameraController.stopVideoRecording();

      // 녹화파일 갖고 페이지 이동
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return VideoPreviewScreen(video: xFile);
        },
      ));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (!_isRecording) {
      _animationController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onRecroding(),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 3,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            // 녹화여부에 따라 색 변경
            color: _isRecording ? Colors.red : Colors.white,
            width: 2,
          ),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation, // 애니메이션 적용
          child: Container(
            width: Sizes.width / 7,
            height: Sizes.width / 7,
            decoration: BoxDecoration(
              color: Colors.red,
              // 녹화여부에 따라 모양 변경
              shape: _isRecording ? BoxShape.rectangle : BoxShape.circle,
              // 녹화 여부에 따라 모양 변경
              borderRadius: _isRecording ? BorderRadius.circular(10) : null,
            ),
          ),
        ),
      ),
    );
  }
}
