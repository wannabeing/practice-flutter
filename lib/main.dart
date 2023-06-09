import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/generated/l10n.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/settings/repos/setting_config_repo.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';
import 'package:may230517/wanda/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // ✅ 앱을 실행하기 전, 필요한 초기화작업을 수행하고 플러터엔진과 프레임워크를 연결시킨다.
  // https://terry1213.github.io/flutter/flutter-widgetsflutterbindingensureinitialized/
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase 초기화
  // https://firebase.google.com/docs/flutter/setup?hl=ko&platform=ios
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ 시간 포맷팅 (영어/한국어 동일 포맷 설정)
  timeago.setLocaleMessages("en", KrCustomMessages());
  timeago.setLocaleMessages("kr", KrCustomMessages());

  // ✅ 앱 자체를 세로모드로 고정설정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  // ✅ 로컬저장소 및 사용자설정 초기화
  final preferences = await SharedPreferences.getInstance();
  final settingConfigRepository = SettingConfigRepository(preferences);

  runApp(
    // ✅ Riverpod 설정 위젯으로 감싸기
    // 로컬저장소를 설정하기 위해 override 사용
    ProviderScope(
      overrides: [
        settingConfigProvider.overrideWith(
          () => SettingConfigViewModel(settingConfigRepository),
        ),
      ],
      child: const App(),
    ),
  );
}

// root Widget은 Material/Cupertino 둘 중 하나를 반드시 return
// google이 만들었으니까 Material을 기본으로 가자..

// 항상 Scaffold(구조)를 설정하자.
// body Padding (h: width/15, v: height/20)
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider), // GoRouter + Provider
      title: "may",

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

      themeMode: ref.watch(settingConfigProvider).darkTheme
          ? ThemeMode.dark
          : ThemeMode.light,

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

        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade200, // 배경 색상
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

        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade100, // 배경 색상
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4F62D2), // input 커서 색상
        ),
      ),
    );
  }
}
