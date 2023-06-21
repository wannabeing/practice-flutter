import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with WidgetsBindingObserver {
  bool _hasPermission = false; // 카메라&마이크 권한 여부
  bool _camMode = true; // 카메라 전/후면모드 설정 (true: 후면모드)
  bool _camFlash = false; // 카메라 플래쉬 설정 (false: 안켜짐)
  bool _isAppLeaved = false; // 사용자가 앱을 떠났는지 여부 (false: 안떠남)

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
      cameras[_camMode == _camMode ? 0 : 1],
      ResolutionPreset.veryHigh,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );
    await _cameraController.initialize(); // 카메라 초기화
    await _cameraController.prepareForVideoRecording(); // IOS 카메라를 위한 세팅
    setState(() {});
  }

  // 카메라 전/후면모드 변경 함수
  Future<void> _toggleCamMode() async {
    _camMode = !_camMode;

    await _initCam();
    setState(() {});
  }

  // 카메라 플래쉬 변경 함수
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

  // 녹화 시작 함수
  Future<void> _startRecording() async {
    if (_cameraController.value.isRecordingVideo) return; // 녹화 중일 경우, 함수 종료

    await _cameraController.startVideoRecording(); // 녹화 시작
  }

  // 녹화 종료 함수
  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return; // 녹화 중이지 않을 경우, 함수 종료
    }

    final video = await _cameraController.stopVideoRecording(); // 녹화된 영상 변수
    if (!mounted) return; // context를 async에서 사용했을 때 생기는 문제때문에 추가

    // 녹화 종료 후, 프리뷰 페이지 이동
    print(video.path);
  }

  // 갤러리 영상 선택 시 함수
  Future<void> _initGallery() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 15),
    );
    if (video == null) return;

    final videoSize = await video.length();
    // 비디오 용량 100MB 제한
    if (videoSize > 100000000) {
      return await _showAlert();
    }
    // 페이지 이동
    if (!mounted) return;
    print(video.path);
  }

  // 용량 초과 알림창 함수
  Future<void> _showAlert() async {
    print("max");
  }

  // 사용자가 앱을 떠났음을 감지하는 함수
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // 권한이 없거나 카메라가 실행되지 않으면 return
    if (!_hasPermission || !_cameraController.value.isInitialized) return;

    // 앱을 떠났을 때 카메라 dispose
    if (state == AppLifecycleState.paused) {
      _isAppLeaved = true;
      setState(() {});
      _cameraController.dispose();
    }
    // 앱에 다시 돌아왔을 때, 권한설정부터 시작
    else if (state == AppLifecycleState.resumed) {
      _isAppLeaved = false;
      setState(() {});
      await _initPermission();
    }
  }

  void _onClose() {
    context.pop();
  }

  @override
  void initState() {
    super.initState();

    _initPermission(); // 권한요청 함수
    WidgetsBinding.instance.addObserver(this); // 사용자가 앱을 떠났음을 감지하기 위해 추가
  }

  @override
  void dispose() {
    // cameraController가 존재할 때만 dispose
    if (_hasPermission || _isAppLeaved) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasPermission && _cameraController.value.isInitialized
          ? SafeArea(
              child: GestureDetector(
                onScaleStart: (details) {
                  _prevScale = _scale;
                  setState(() {});
                },
                onScaleUpdate: (details) {
                  if (_prevScale * details.scale >= 1.0) {
                    _scale = _prevScale * details.scale;
                  }
                  setState(() {});
                },
                onScaleEnd: (details) {
                  _prevScale = _scale;
                  setState(() {});
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.diagonal3(
                        Vector.Vector3(_scale, _scale, _scale)),
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
                            // ✅ 1. 닫기버튼
                            GestureDetector(
                              onTap: () => _onClose(),
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: Sizes.width / 20,
                                  vertical: Sizes.height / 40,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.xmark,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    // ✅ 2-1. 플래쉬 버튼
                                    GestureDetector(
                                      onTap: () => _onClose(),
                                      child: Container(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                          horizontal: Sizes.width / 20,
                                          vertical: Sizes.height / 40,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    // ✅
                                    GestureDetector(
                                      onTap: () => _onClose(),
                                      child: Container(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                          horizontal: Sizes.width / 20,
                                          vertical: Sizes.height / 40,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _onClose(),
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: Sizes.width / 20,
                                      vertical: Sizes.height / 40,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _onClose(),
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: Sizes.width / 20,
                                      vertical: Sizes.height / 40,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _onClose(),
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: Sizes.width / 20,
                                      vertical: Sizes.height / 40,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                    ),
                                  ),
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
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: Sizes.height / 3),
                    const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white),
                    Gaps.vheight40,
                    const Text(
                      "로딩중...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
