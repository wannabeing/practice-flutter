import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:timeago/timeago.dart';

class Utils {
  // ✅ 글자 그림자
  static final List<Shadow> textShadow = [
    const Shadow(
      blurRadius: Sizes.size10,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ];

  static const Duration duration200 = Duration(
    milliseconds: 300,
  );

  static const Duration duration300 = Duration(
    milliseconds: 300,
  );

  // ✅ 날짜 yyyyMMdd 형식 출력 함수
  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  // ✅ GET firebase 아바타이미지 URL 함수
  static String getAvatarURL(String uid) {
    return "https://firebasestorage.googleapis.com/v0/b/may-230517.appspot.com/o/avatarIMGs%2F$uid?alt=media&nocache=${DateTime.now().toString()}";
  }
}

// ✅ 날짜 포맷팅 함수
class KrCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '방금 전';
  @override
  String aboutAMinute(int minutes) => '$minutes분 전';
  @override
  String minutes(int minutes) => '$minutes분 전';
  @override
  String aboutAnHour(int minutes) => '$minutes분 전';
  @override
  String hours(int hours) => '$hours시간 전';
  @override
  String aDay(int hours) => '$hours시간 전';
  @override
  String days(int days) => '$days일 전';
  @override
  String aboutAMonth(int days) => '$days일 전';
  @override
  String months(int months) => '$months개월 전';
  @override
  String aboutAYear(int year) => '$year년 전';
  @override
  String years(int years) => '$years년 전';
  @override
  String wordSeparator() => ' ';
}

// ✅ firebase Error 스낵바
SnackBar errorSnackBar(Object? errorMsg) {
  return SnackBar(
    showCloseIcon: true,
    closeIconColor: Colors.white,
    content: Text(
      "$errorMsg",
      textAlign: TextAlign.center,
    ),
  );
}
