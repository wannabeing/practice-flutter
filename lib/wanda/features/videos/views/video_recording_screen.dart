import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/videos/views/video_preview_screen.dart';
import 'package:may230517/wanda/features/videos/views/widgets/recordings/re_loading_widget.dart';
import 'package:may230517/wanda/features/videos/views/widgets/recordings/re_toggle_icon_widget.dart';
import 'package:may230517/wanda/features/videos/views/widgets/recordings/recording_button.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector;

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false; // 카메라&마이크 권한 여부
  bool _camMode = true; // 카메라 전/후면모드 설정 (true: 후면모드)
  bool _camFlash = false; // 카메라 플래쉬 설정 (false: 안켜짐)

  // 줌 인&아웃 변수
  double _scale = 1.0;
  double _prevScale = 1.0;

  late CameraController _cameraController;

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
      _hasPermission = true;
      await _initCam(); // 카메라 초기화 함수 실행

      setState(() {});
    } else {
      return;
    }
  }

  // 🚀 카메라 초기화 함수
  Future<void> _initCam() async {
    /* ❌ imagePicker로 영상 만들기 (기능이 제한적이라 일단 주석처리)
    final video = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear, // 카메라 rear 방향 설정
      maxDuration: const Duration(seconds: 10), // 동영상 길이 최대 10초 설정
    );
    */

    // 카메라 전/후면모드 설정
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[_camMode ? 0 : 1],
      ResolutionPreset.veryHigh,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );
    await _cameraController.initialize(); // 카메라 초기화
    await _cameraController.prepareForVideoRecording(); // IOS 영상녹화 싱크를 위한 세팅
    setState(() {});
  }

  // 🚀 페이지 닫기 함수
  void _onClose() {
    context.pop();
  }

  // 🚀 카메라 전/후면모드 변경 함수
  Future<void> _toggleCamMode() async {
    _camMode = !_camMode;

    await _initCam();
    setState(() {});
  }

  // 🚀 카메라 플래쉬 변경 함수
  Future<void> _toggleFlashMode() async {
    if (!_camMode) return; // 카메라 전면모드일 경우, 함수 종료

    if (_camFlash) {
      await _cameraController.setFlashMode(FlashMode.off);
    } else {
      await _cameraController.setFlashMode(FlashMode.torch);
    }
    _camFlash = !_camFlash;
    setState(() {});
  }

  // 🚀 갤러리 선택 함수
  Future<void> _pickVideo() async {
    // 갤러리 권한 없으면 return

    final fromGallery =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    // 갤러리 영상 갖고 페이지 이동
    if (fromGallery == null) return;
    if (!mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return VideoPreviewScreen(
          video: fromGallery,
          isGalleryVideo: true,
        );
      },
    ));
  }

  @override
  void initState() {
    super.initState();

    _initPermission(); // 권한요청 함수
  }

  @override
  void dispose() {
    super.dispose();
    // 사용자 권한이 있고 카메라컨트롤러가 초기화 된 상태일 경우에만 dispose -> 페이지 나갔을 때
    if (_hasPermission && _cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasPermission && _cameraController.value.isInitialized
          ? SafeArea(
              // ✅ 줌인/아웃기능 구현
              child: GestureDetector(
                onScaleStart: (details) {
                  _prevScale = _scale;
                  setState(() {});
                },
                onScaleUpdate: (details) {
                  // 1.0보다 작을 시, 줌아웃 안함
                  if (_prevScale * details.scale >= 1.0) {
                    _scale = _prevScale * details.scale;
                  }
                  setState(() {});
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Transform(
                    // 카메라 줌 인&아웃시, 가운데 고정
                    alignment: FractionalOffset.center,
                    // 카메라 줌 인&아웃 애니메이션
                    transform: Matrix4.diagonal3(
                        vector.Vector3(_scale, _scale, _scale)),
                    child: CameraPreview(
                      _cameraController,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.width / 20,
                          vertical: Sizes.height / 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ❌ 1-1. 녹화 로딩 바 (미구현)
                                Container(
                                  width: double.infinity,
                                  height: Sizes.height / 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Gaps.vheight40,
                                // ✅ 1-2. 닫기버튼
                                ReToggleIconButton(
                                  onTap: () => _onClose(),
                                  iconData: FontAwesomeIcons.xmark,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    // ✅ 2-1. 플래쉬 버튼
                                    ReToggleIconButton(
                                      onTap: () => _toggleFlashMode(),
                                      iconData: Icons.flashlight_off_rounded,
                                      changeIconData:
                                          Icons.flashlight_on_rounded,
                                      isChange: _camFlash,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ✅ 3-1. 갤러리 버튼
                                ReToggleIconButton(
                                  onTap: () => _pickVideo(),
                                  iconData: FontAwesomeIcons.image,
                                ),
                                // ✅ 3-2. 녹화 버튼
                                RecordingButton(
                                  cameraController: _cameraController,
                                ),
                                // ✅ 3-3. 카메라 전환 버튼
                                ReToggleIconButton(
                                  onTap: () => _toggleCamMode(),
                                  iconData: FontAwesomeIcons.cameraRotate,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : ReLoadingWidget(
              onTap: () => _pickVideo(),
            ),
    );
  }
}
