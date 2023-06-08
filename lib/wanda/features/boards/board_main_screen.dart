import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class BoardMainScreen extends StatelessWidget {
  BoardMainScreen({super.key});

  final _tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
        appBar: AppBar(
          title: const CupertinoSearchTextField(),
          elevation: 1,
          bottom: TabBar(
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
        body: TabBarView(
          children: [
            // ✅ 1. Top그리드뷰
            Scrollbar(
              child: GridView.builder(
                itemCount: 20,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width / 30,
                  vertical: Sizes.height / 60,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // grid 개수
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
            // ✅ 2. Users그리드뷰
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.contain,
                              placeholder: "assets/images/placeholder.png",
                              image:
                                  "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
                            ),
                          ),
                        ),
                      ),
                      Gaps.v5,
                      // 첫째줄 (작성자, 좋아요개수)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: Sizes.width / 30,
                                foregroundImage: const NetworkImage(
                                    "https://avatars.githubusercontent.com/u/79440384"),
                              ),
                              Gaps.h5,
                              SizedBox(
                                width: Sizes.width / 5,
                                child: const Text(
                                  "작성자작성자작성자작성자작성자작성자",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.heart,
                                  color: Colors.grey.shade500),
                              Gaps.h5,
                              Text(
                                "3,333",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              Gaps.h5,
                            ],
                          ),
                        ],
                      ),
                      Gaps.v5,
                      // 둘째줄 (해시태그)
                      const Text(
                        "#해시태그 #해시태그 #해시태그 #해시태그 #해시태그",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
            for (var tab in _tabs.skip(2))
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}
