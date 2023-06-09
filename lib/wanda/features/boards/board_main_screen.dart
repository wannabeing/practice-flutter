import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/boards/widgets/top_tabbar_view.dart';
import 'package:may230517/wanda/features/boards/widgets/user_tabbar_view.dart';
import 'package:may230517/wanda/features/boards/widgets/search_textfield_widget.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';

enum BoardTabTypes { ranking, shorts }

class BoardMainScreen extends ConsumerStatefulWidget {
  const BoardMainScreen({
    super.key,
    BoardTabTypes? boardTabTypes,
  }) : boardTabTypes = boardTabTypes ?? BoardTabTypes.ranking;

  // 🌐 RouteName
  static String routeName = "/boards";
  final BoardTabTypes boardTabTypes;

  @override
  ConsumerState<BoardMainScreen> createState() => _BoardMainScreenState();
}

class _BoardMainScreenState extends ConsumerState<BoardMainScreen> {
  final _tabs = [
    "랭킹",
    "쇼츠",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  // 🚀 언포커싱 함수
  void _onUnfocus() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 탭 선택 함수
  int setInitialTab(BoardTabTypes tabType) {
    switch (tabType) {
      case BoardTabTypes.ranking:
        return 0;
      case BoardTabTypes.shorts:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: setInitialTab(widget.boardTabTypes),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true, // 고정
              elevation: 1,
              // ✅ 1. 검색창
              title: const SearchTextField(),
              // ✅ 2. 검색창 탭 바
              bottom: TabBar(
                onTap: (index) => _onUnfocus(),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width / 20,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.width / 25,
                ),
                labelColor: Theme.of(context).primaryColor, // 셀렉트 컬러
                unselectedLabelColor: ref.watch(settingConfigProvider).darkTheme
                    ? Colors.white70
                    : Colors.grey.shade700,
                indicatorColor: Theme.of(context).primaryColor, // 밑줄 컬러
                isScrollable: true, // 탭 스크롤 여부
                splashFactory: InkSplash.splashFactory, // 터치효과
                splashBorderRadius:
                    BorderRadius.circular(30), // 터치효과 borderadius
                tabs: [
                  for (var tab in _tabs)
                    Tab(
                      text: tab,
                    ),
                ],
              ),
            ),
          ];
        },
        // ✅ 3. 탭 뷰
        body: GestureDetector(
          onTap: () => _onUnfocus(),
          child: TabBarView(
            children: [
              // ✅ [Top]
              const TopTabbarView(),
              // ✅ [Users]
              const UserTabbarView(),

              // 나머지 뷰
              for (var tab in _tabs.skip(2))
                Center(
                  child: Text(tab),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
  return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
        appBar: AppBar(
          // ✅ 1. 검색창
          title: const SearchTextField(),
          elevation: 1,
          // ✅ 2.탭 바
          bottom: TabBar(
            onTap: (index) => _onUnfocus(),
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 20,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.width / 25,
            ),
            labelColor: Theme.of(context).primaryColor, // 셀렉트 컬러
            unselectedLabelColor: Colors.grey.shade700,
            indicatorColor: Theme.of(context).primaryColor, // 밑줄 컬러
            isScrollable: true, // 탭 스크롤 여부
            splashFactory: InkSplash.splashFactory, // 터치효과
            splashBorderRadius: BorderRadius.circular(30), // 터치효과 borderadius
            tabs: [
              for (var tab in _tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body:
            // ✅ 3. 탭 뷰
            GestureDetector(
          onTap: () => _onUnfocus(),
          child: TabBarView(
            children: [
              // ✅ [Top]
              Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      height: Sizes.height / 40,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.black,
                        width: 0.2,
                      ))),
                    );
                  },
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: Sizes.width / 20,
                      ),
                      // ✅ 탑 리스트뷰 위젯
                      child: TopListViewWidget(
                        index: index,
                        nickname: "닉네임",
                        follower: "팔로워 입력",
                      ),
                    );
                  },
                ),
              ),

              // ✅ [Users] 그리드뷰
              Scrollbar(
                child: GridView.builder(
                  itemCount: 20,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                      .onDrag, // 드래그시 키보드 unfocus
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size5,
                    vertical: Sizes.height / 60,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // grid 개수
                    crossAxisSpacing: Sizes.size10, // 가로 간격
                    mainAxisSpacing: Sizes.height / 60, // 세로 간격
                    childAspectRatio: 9 / 16, // 자식위젯 비율 설정
                  ),
                  itemBuilder: (context, index) {
                    // ✅ 유저 리스트뷰 위젯
                    return const UserListViewWidget(
                      nickname: "작성자작성자작성자작성자작성자작성자",
                      likes: "3,333",
                      hashtags: "#해시태그 #해시태그 #해시태그 #해시태그 #해시태그",
                    );
                  },
                ),
              ),
              // 나머지 뷰
              for (var tab in _tabs.skip(2))
                Center(
                  child: Text(tab),
                ),
            ],
          ),
        ),
      ),
    );

 */


/*
              Scrollbar(
                child: GridView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 30,
                    vertical: Sizes.height / 60,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // grid 개수
                    crossAxisSpacing: Sizes.width / 30, // 가로 간격
                    mainAxisSpacing: Sizes.height / 60, // 세로 간격
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.amber,
                            child: const Center(
                              child: Text("main"),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              */
