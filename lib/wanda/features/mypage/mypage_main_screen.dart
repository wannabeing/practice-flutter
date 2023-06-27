import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/mypage/widgets/introduce/bottom_widget.dart';
import 'package:may230517/wanda/features/mypage/widgets/introduce/introduce_tabbar.dart';
import 'package:may230517/wanda/features/mypage/widgets/introduce/title_widget.dart';
import 'package:may230517/wanda/features/mypage/widgets/post_tabbar_view.dart';

enum MyPageTabType { feed, shorts, likes }

class MyPageMainScreen extends ConsumerStatefulWidget {
  const MyPageMainScreen({
    super.key,
    required this.userId,
    MyPageTabType? tabtype,
  }) : tabtype = tabtype ?? MyPageTabType.feed;

  // 🌐 RouteName
  static String routeName = "/users/:id";

  final String userId;
  final MyPageTabType tabtype;

  @override
  ConsumerState<MyPageMainScreen> createState() => _MyPageMainScreenState();
}

class _MyPageMainScreenState extends ConsumerState<MyPageMainScreen> {
  // 🚀 탭 선택 함수
  int setInitialTab(MyPageTabType tabType) {
    switch (tabType) {
      case MyPageTabType.feed:
        return 0;
      case MyPageTabType.shorts:
        return 1;
      case MyPageTabType.likes:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyPageTabType.values.length, // 마이페이지는 3개의 탭을 갖는다
      initialIndex: setInitialTab(widget.tabtype),

      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // ✅ 1. appbar title
            MypageIntroduceTitleWidget(
              userId: widget.userId,
            ),
            // ✅ 2. appbar bottom
            const MyPageIntroduceBottomWidget(
              avatarId: "https://avatars.githubusercontent.com/u/79440384",
              postLength: "569",
              follower: "1,007",
              following: "1,602",
              nickname: "닉네임",
              descText:
                  "소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글소개글",
            ),
            // ✅ 3. appbar tabbar (탭 바)
            const MyPageIntroduceTabbarWidget(),

            /*
              ❌ appbar Tabbar -> DarkTheme 적용안되서 주석처리
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPageSliverPersistentTabbar(
                isDarkTheme: ref.watch(settingConfigProvider).darkTheme,
              ),
            ),
            */
          ];
        },
        // 3. ✅ body (tabbar view)
        body: const TabBarView(
          children: [
            // ✅ 1. 이미지 게시글
            PostTabbarView(type: TabbarViewType.post),
            // ✅ 2. 영상 게시글
            PostTabbarView(type: TabbarViewType.video),
            // ✅ 3. 좋아요 게시글
            PostTabbarView(type: TabbarViewType.post),
          ],
        ),
      ),
    );
  }
}
