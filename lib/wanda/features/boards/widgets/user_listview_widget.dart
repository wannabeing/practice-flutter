import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class UserListViewWidget extends StatelessWidget {
  final String nickname;
  final String likes;
  final String hashtags;

  const UserListViewWidget({
    super.key,
    required this.nickname,
    required this.likes,
    required this.hashtags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          // ✅ 1. 각 이미지
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
                // ✅ 각 게시물 이미지 링크
                image:
                    "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
              ),
            ),
          ),
        ),
        Gaps.v5,
        // ✅ 2. 첫째줄 (작성자, 좋아요개수)
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
                  child: Text(
                    nickname, // 작성자
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.heart, color: Colors.grey.shade500),
                Gaps.h5,
                Text(
                  likes, // 좋아요 개수
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                Gaps.h5,
              ],
            ),
          ],
        ),
        Gaps.v5,
        // 둘째줄 (해시태그)
        Text(
          hashtags, // 해시태그
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
