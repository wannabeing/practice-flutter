import 'package:flutter/material.dart';
import 'package:may230517/wanda/features/mypage/widgets/introduce/bottom_widget.dart';
import 'package:may230517/wanda/features/mypage/widgets/introduce/title_widget.dart';
import 'package:may230517/wanda/features/mypage/widgets/post_tabbar_view.dart';
import 'package:may230517/wanda/features/mypage/widgets/persistent_tabbar.dart';

class MyPageMainScreen extends StatefulWidget {
  const MyPageMainScreen({super.key});

  @override
  State<MyPageMainScreen> createState() => _MyPageMainScreenState();
}

class _MyPageMainScreenState extends State<MyPageMainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 마이페이지는 3개의 탭을 갖는다
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // ✅ 1. appbar title
            const MypageIntroduceTitleWidget(
              userId: "아이디",
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
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPageSliverPersistentTabbar(),
            ),
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


/* 
3. appbar tabbar를 SliverAppBar로 만들어 봄

  SliverAppBar(
    toolbarHeight: 0,
    pinned: true, // 고정
    expandedHeight: 0,
    flexibleSpace: TabBar(
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.grey.shade500,
      labelColor: Colors.grey.shade900,
      indicatorColor: Colors.grey.shade900,
      tabs: [
        // indicator 너비때문에 pdding 설정함
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 20,
          ),
          child: const Icon(Icons.grid_on_rounded),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 20,
          ),
          child: const Icon(Icons.video_collection_rounded),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 20,
          ),
          child: const FaIcon(FontAwesomeIcons.heart),
        ),
      ],
    ),
  ),
*/