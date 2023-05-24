import 'package:flutter/material.dart';
import 'package:may230517/webtoon/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final String id, title, thumb;

  const WebtoonWidget({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  void _onPush(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) =>
            WebtoonDetailScreen(id: id, title: title, thumb: thumb),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPush(context),
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.network(
                thumb,
                // 추가하는이유: 네이버가 제공하는 이미지를 브라우저가 아닌 곳에서 사용하기 위해
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "SBAggro",
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
