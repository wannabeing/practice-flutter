import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';

void main() {
  runApp(const App());
}

// root Widget은 Material/Cupertino 둘 중 하나를 반드시 return
// google이 만들었으니까 Material을 기본으로 가자..

// 항상 Scaffold(구조)를 설정하자.
// body Padding (h: 32, v: 24)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "may",
      home: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
        backgroundColor: Colors.grey.shade50,
        body: const NavMainScreen(),
      ),
      theme: ThemeData(
        fontFamily: "SWEET",
        primaryColor: const Color(0xFF4F62D2),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade50,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: "SWEET",
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
      ),
    );
  }
}
