import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const workingTime = 1500; // 1500 = 25분
  static const restTime = 300; // 300 = 5분

  late Timer _timer; // 타이머 클래스
  int _totalSeconds = workingTime; // 25분 초기화
  bool _isRunning = false; // 타이머 작동여부
  bool _isRest = false; // 쉬는시간 여부
  int _count = 0; // 포모도로 횟수 카운트

  // 버튼 함수
  void _onTap() {
    // 1. Pause: 타이머 정지
    if (_isRunning) {
      _timer.cancel(); // 타이머 정지
      // 플레이상태에서 눌렀으니 정지상태로 변경
      setState(() {
        _isRunning = false;
      });
    }
    // 2. Play: 타이머 시작
    else {
      // 1초마다 _onTikTok 함수 실행
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        _onTikTok,
      );
      // 정지상태에서 눌렀으니 플레이 상태로 변경
      setState(() {
        _isRunning = true;
      });
    }
  }

  // 1초마다 실행하는 함수
  void _onTikTok(Timer timer) {
    // 0초 & 쉬는시간이 되었다는 뜻
    if (_totalSeconds == 0 && !_isRest) {
      setState(() {
        _isRest = true; // 쉬는시간 세팅
        _totalSeconds = restTime + 1; // 5분 초기화
      });
    }
    // 0초 & 일하는시간이 되었다는 뜻
    if (_totalSeconds == 0 && _isRest) {
      setState(() {
        _isRest = false; // 쉬는시간 끝
        _totalSeconds = workingTime + 1; // 25분 초기화
        _count += 1; // 포모도로 1회 완료
        _isRunning = false; // 아이콘 전환
      });
      timer.cancel(); // 타이머 정지
    }
    // 0초가 될 때까지 1초 뺴기
    setState(() {
      _totalSeconds -= 1;
    });
  }

  // 시간 포맷팅 함수
  String _secondsFormat(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  // 타이머 초기화 함수
  void _onRefresh() {
    _timer.cancel();
    setState(() {
      _totalSeconds = workingTime;
      _isRunning = false;
      _isRest = false;
      _count = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    // timer 초기화
    _timer = Timer(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isRest ? const Color(0xFF3FA47C) : const Color(0xFFED3C50),
      body: Column(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(right: 30),
                    child: IconButton(
                      onPressed: _onRefresh,
                      icon: const FaIcon(FontAwesomeIcons.arrowRotateLeft),
                      iconSize: 30,
                      color: const Color(0xFFFFD8DC),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                _secondsFormat(_totalSeconds),
                style: const TextStyle(
                  color: Color(0xFFFFD8DC),
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: _onTap,
                icon: _isRunning
                    ? const Icon(Icons.pause_circle_filled_outlined)
                    : const Icon(Icons.play_circle_filled_outlined),
                iconSize: 180,
                color: const Color(0xFFFFD8DC),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD8DC),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "포모도로",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$_count",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
