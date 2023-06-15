import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/boards/widgets/top_listview_widget.dart';

class TopTabbarView extends StatelessWidget {
  const TopTabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        padding: EdgeInsets.only(
          bottom: Sizes.height / 20,
        ),
        separatorBuilder: (context, index) {
          // ✅ 구분 위젯
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
          return TopListViewWidget(
            index: index,
            nickname: "닉네임",
            follower: "팔로워 입력",
          );
        },
      ),
    );
  }
}
