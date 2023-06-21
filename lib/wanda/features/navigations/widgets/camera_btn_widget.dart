import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/videos/video_recording_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraBtnWidget extends StatefulWidget {
  const CameraBtnWidget({super.key});

  @override
  State<CameraBtnWidget> createState() => _CameraBtnWidgetState();
}

class _CameraBtnWidgetState extends State<CameraBtnWidget> {
  bool _hasPermission = false; // 카메라&마이크 권한 여부

  // 🚀 버튼 함수
  void _onTap() {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const VideoRecordingScreen(),
    ));

    if (_hasPermission) {
      // final video = await ImagePicker().pickVideo(
      //   source: ImageSource.camera,
      //   preferredCameraDevice: CameraDevice.rear, // 카메라 rear 방향 설정
      //   maxDuration: const Duration(seconds: 10), // 동영상 길이 최대 10초 설정
      // );
    } else {
      return;
    }
  }

  // 🚀 카메라&마이크 권한요청 함수
  Future<void> _initPermission() async {
    final camPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    // 권한요청 거부 여부
    final isCamDenied =
        camPermission.isDenied || camPermission.isPermanentlyDenied;

    final isMicDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    // 두개의 권한을 모두 가진 경우
    if (!isMicDenied && !isCamDenied) {
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _onTap(),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: Sizes.height / 40,
              child: Container(
                padding: const EdgeInsets.all(Sizes.size14),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 10,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.camera,
                    size: Sizes.size32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Sizes.width / 10,
              height: Sizes.height / 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "카메라",
                  style: TextStyle(
                    fontSize: Sizes.width / 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
