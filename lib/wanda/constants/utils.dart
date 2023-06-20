import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:timeago/timeago.dart';

class Utils {
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

  static bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
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
