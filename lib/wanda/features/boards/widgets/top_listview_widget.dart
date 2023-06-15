import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class TopListViewWidget extends StatelessWidget {
  final int index;
  final String nickname;
  final String follower;
  const TopListViewWidget({
    super.key,
    required this.index,
    required this.nickname,
    required this.follower,
  });

  // 🚀 팔로우 클릭 함수
  void _onFollow() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 20,
          ),
          // ✅ 1. 사용자 정보
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ 1. 인기 순위
              Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: Sizes.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // ✅ 2. 프사/닉네임/팔로워숫자/팔로우버튼
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: Sizes.width / 20,
                    foregroundImage: const NetworkImage(
                        "https://avatars.githubusercontent.com/u/79440384"),
                  ),
                  title: Text(nickname), // 닉네임
                  subtitle: Text(follower), // 팔로워 숫자
                  // 팔로우 버튼
                  trailing: GestureDetector(
                    onTap: () => _onFollow(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.width / 30,
                        vertical: Sizes.size7,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "팔로우",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ✅ 2. 갤러리
        Container(
          height: Sizes.height / 5, // listView 높이 설정
          padding: EdgeInsets.only(
            left: Sizes.width / 20,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // 가로 설정
            itemCount: 20,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.contain,
                            placeholder: "assets/images/placeholder.png",
                            // ✅ 각 게시물 이미지
                            image:
                                "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          child: Row(
                            children: [
                              Gaps.hwidth20,
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.white,
                                size: Sizes.width / 25,
                              ),
                              Gaps.h5,
                              const Text(
                                "32", // ✅ 각 게시물 좋아요
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.h20,
                ],
              );
            },
          ),
        ), // 옆으로 스크롤
      ],
    );
  }
}
