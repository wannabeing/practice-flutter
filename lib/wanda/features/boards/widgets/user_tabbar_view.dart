import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/boards/widgets/user_listview_widget.dart';

class UserTabbarView extends StatelessWidget {
  const UserTabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        itemCount: 20,
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag, // 드래그시 키보드 unfocus
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
    );
  }
}
