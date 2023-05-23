import 'package:flutter/material.dart';
import 'package:may230517/services/webtoon_api_service.dart';
import 'package:may230517/webtoon/models/webtoon_detail.dart';
import 'package:may230517/webtoon/models/webtoon_episode.dart';

class WebtoonDetailScreen extends StatelessWidget {
  final String id, title, thumb;

  WebtoonDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  // ✅ 비동기처리 데이터
  late final Future<WebtoonDetailModel> detail =
      WebtoonApiService.getToonById(id);
  late final Future<List<WebtoonEpisodeModel>> episodes =
      WebtoonApiService.getEpisodesBy(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "SBAggro",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Hero(
              tag: id,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            blurRadius: 5,
                            offset: const Offset(
                                0, 5), // changes position of shadow
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
                ],
              ),
            ),
            // ☄️ Future 웹툰 상세 정보
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: detail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String genreString = snapshot.data!.genre;
                  List<String> genreList = genreString.split(",");
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "SBAggro",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "연령",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                  fontFamily: "SBAggro",
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data!.age,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "SBAggro",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data!.genre,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SBAggro",
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                // 🌿 로딩중
                return const CircularProgressIndicator.adaptive();
              },
            ),
          ],
        ),
      ),
    );
  }
}
