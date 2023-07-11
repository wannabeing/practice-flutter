import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/auth/repos/auth_repo.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/birth_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/email_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/login_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/name_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/pw_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/interest_screen.dart';
import 'package:may230517/wanda/features/auth/views/login_main_screen.dart';
import 'package:may230517/wanda/features/auth/views/signup_main_screen.dart';
import 'package:may230517/wanda/features/boards/board_main_screen.dart';
import 'package:may230517/wanda/features/chats/views/chat_detail_screen.dart';
import 'package:may230517/wanda/features/chats/views/chat_main_screen.dart';
import 'package:may230517/wanda/features/chats/views/chat_select_screen.dart';
import 'package:may230517/wanda/features/mypage/mypage_main_screen.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';
import 'package:may230517/wanda/features/onboard/onboard_main_screen.dart';
import 'package:may230517/wanda/features/settings/views/setting_main_screen.dart';

import 'features/videos/views/video_main_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: OnboardMainScreen.routeName,
    // 🚀 로그인이 되어있다면 메인페이지로 REDIRECT
    redirect: (context, state) {
      final isLoggedIn = ref.watch(authRepo).isLoggedIn;
      if (isLoggedIn) {
        // subloc: 유저가 있는 곳
        if (state.subloc == OnboardMainScreen.routeName) {
          return NavMainScreen.routeName;
        }
      }
      return null;
    },
    routes: [
      // ✅ 0. 온보딩 페이지 (onboarding)
      GoRoute(
        path: OnboardMainScreen.routeName,
        builder: (context, state) => const OnboardMainScreen(),
      ),
      // ✅ 1. 회원가입 관련 페이지 (signup)
      GoRoute(
        path: SignupMainScreen.routeName,
        builder: (context, state) => const SignupMainScreen(),
        routes: [
          // signup/interests
          GoRoute(
            path: InterestScreen.routeName,
            name: InterestScreen.routeName,
            builder: (context, state) => const InterestScreen(),
          ),
          // signup/birth
          GoRoute(
            path: BirthFormScreen.routeName,
            name: BirthFormScreen.routeName,
            builder: (context, state) => const BirthFormScreen(),
          ),
          // signup/email
          GoRoute(
            path: EmailFormScreen.routeName,
            name: EmailFormScreen.routeName,
            builder: (context, state) => const EmailFormScreen(),
          ),
          // signup/username
          GoRoute(
            path: NameFormScreen.routeName,
            name: NameFormScreen.routeName,
            builder: (context, state) => const NameFormScreen(),
          ),
          // signup/pw
          GoRoute(
            path: PwFormScreen.routeName,
            name: PwFormScreen.routeName,
            builder: (context, state) => const PwFormScreen(),
          ),
        ],
      ),
      // ✅ 2. 로그인 페이지 (login)
      GoRoute(
        path: LoginMainScreen.routeName,
        builder: (context, state) => const LoginMainScreen(),
        routes: [
          // login/form
          GoRoute(
            path: LoginFormScreen.routeName,
            name: LoginFormScreen.routeName,
            builder: (context, state) => const LoginFormScreen(),
          ),
        ],
      ),

      // ✅ 3. 메인 홈페이지 (/)
      GoRoute(
        path: NavMainScreen.routeName,
        builder: (context, state) => const NavMainScreen(),
      ),

      // ✅ 4. 완다 게시판페이지 (boards?tabs=ranking)
      GoRoute(
        path: BoardMainScreen.routeName,
        builder: (context, state) {
          String? tabTypes = state.queryParams["tabs"]; // 유저에게 받은 탭타입
          BoardTabTypes tabType; // 저장할 탭타입

          if (tabTypes == "ranking" || tabTypes == "shorts") {
            tabType = BoardTabTypes.values.firstWhere(
              // TabType.abc에서 abc만 추출하여 비교
              (type) => type.toString().split('.').last == tabTypes,
              orElse: () => BoardTabTypes.ranking,
            );
          } else {
            tabType = BoardTabTypes.ranking;
          }
          return BoardMainScreen(
            boardTabTypes: tabType,
          );
        },
      ),

      // ✅ 5. 채팅 페이지 (chats)
      GoRoute(
        path: ChatMainScreen.routeName,
        builder: (context, state) => const ChatMainScreen(),
        routes: [
          // chats/select
          GoRoute(
            path: ChatSelectScreen.routeName,
            builder: (context, state) => const ChatSelectScreen(),
          ),
          // chats/:id
          GoRoute(
            path: ChatDetailScreen.routeName,
            builder: (context, state) {
              final id = state.params["username"]!; // 상대방 userID
              return ChatDetailScreen(
                chatOpp: UserModel.empty(),
              );
            },
          ),
        ],
      ),

      // ✅ 6. 마이 페이지 (users/:id?tabs=feed)
      GoRoute(
        path: MyPageMainScreen.routeName,
        builder: (context, state) {
          // final id = state.params["userId"]!; // userID

          String? tabTypes = state.queryParams["tabs"]; // 유저에게 받은 탭타입
          MyPageTabType tabType; // 저장할 탭타입

          if (tabTypes == "feed" ||
              tabTypes == "shorts" ||
              tabTypes == "likes") {
            tabType = MyPageTabType.values.firstWhere(
              // TabType.abc에서 abc만 추출하여 비교
              (type) => type.toString().split('.').last == tabTypes,
              orElse: () => MyPageTabType.feed,
            );
          } else {
            tabType = MyPageTabType.feed;
          }

          return const MyPageMainScreen();
        },
      ),
      // ✅ 7. 마이 페이지 프로필 수정 (settings)

      // ✅ 7. 설정 페이지 (settings)
      GoRoute(
        path: SettingMainScreen.routeName,
        builder: (context, state) => const SettingMainScreen(),
      ),

      // ✅ 8. 비디오 페이지 (videos/:id)
      GoRoute(
        path: VideoMainScreen.routeName,
        builder: (context, state) {
          final id = state.params["videoId"]!; // videoID
          return VideoMainScreen(videoId: id);
        },
      ),
    ],
  );
});
