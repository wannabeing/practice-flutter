import 'package:flutter/material.dart';
import 'package:may230517/webtoon/webtoon_screen.dart';

void main() {
  runApp(const App());
}

// root Widget은 Material/Cupertino 둘 중 하나를 반드시 return
// google이 만들었으니까 Material을 기본으로 가자..

// 항상 Scaffold(구조)를 설정하자.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "may",
      home: WebtoonScreen(),
    );
  }
}
