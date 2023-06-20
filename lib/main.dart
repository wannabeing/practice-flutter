import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:may230517/generated/l10n.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  // 앱을 실행하기 전, 필요한 초기화작업을 수행하고 플러터엔진과 프레임워크를 연결시킨다.
  // https://terry1213.github.io/flutter/flutter-widgetsflutterbindingensureinitialized/
  WidgetsFlutterBinding.ensureInitialized();

  // 시간 포맷팅 (영어/한국어 동일 포맷 설정)
  timeago.setLocaleMessages("en", KrCustomMessages());
  timeago.setLocaleMessages("kr", KrCustomMessages());

  // 앱 자체를 세로모드로 고정설정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
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
      // 번역에 필요한 리소스 제공 설정
      localizationsDelegates: const [
        S.delegate, // vscode extension
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // 번역지원 언어설정
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],

      themeMode: ThemeMode.system,
      // ✅ 라이트모드 테마
      theme: ThemeData(
        fontFamily: "SWEET", // 폰트 설정
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
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: Colors.black87,
          ),
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4F62D2), // input 커서 색상
        ),
      ),
      // ✅ 다크모드 테마
      darkTheme: ThemeData(
        fontFamily: "SWEET",
        brightness: Brightness.dark, // 기본 값을 다크모드로 설정
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFF4F62D2),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "SWEET",
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),

        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: Colors.black87,
          ),
        ),

        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4F62D2), // input 커서 색상
        ),
      ),
    );
  }
}
