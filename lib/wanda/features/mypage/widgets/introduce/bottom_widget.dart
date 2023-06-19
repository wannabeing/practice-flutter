import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';

class MyPageIntroduceBottomWidget extends StatelessWidget {
  final String avatarId, postLength, follower, following, nickname, descText;
  const MyPageIntroduceBottomWidget({
    super.key,
    required this.avatarId,
    required this.postLength,
    required this.follower,
    required this.following,
    required this.nickname,
    required this.descText,
  });

  // 🚀 팔로우버튼 함수
  void _onFollow() {}
  // 🚀 메시지버튼 함수
  void _onMsg() {}

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width / 20,
          vertical: Sizes.height / 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 1. 프로필/게시물/팔로워/팔로잉
            Row(
              children: [
                CircleAvatar(
                  radius: Sizes.width / 10,
                  foregroundImage: NetworkImage(avatarId),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            postLength,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("게시물"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            follower,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("팔로워"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            following,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("팔로잉"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gaps.vheight40,
            // ✅ 2. 닉네임
            Text(
              nickname,
              style: TextStyle(
                  fontSize: Sizes.width / 25, fontWeight: FontWeight.bold),
            ),
            Gaps.v5,
            // ✅ 3. 소개글
            Text(
              descText,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            Gaps.vheight50,
            // ✅ 4. 팔로우/메시지 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _onFollow(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width / 6,
                      vertical: Sizes.width / 40,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "팔로우",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onMsg(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width / 6,
                      vertical: Sizes.width / 40,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.isDarkMode(context)
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "메시지",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
