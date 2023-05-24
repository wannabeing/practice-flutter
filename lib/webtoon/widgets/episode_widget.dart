import 'package:flutter/material.dart';
import 'package:may230517/webtoon/models/webtoon_episode.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EpisodeWidget extends StatelessWidget {
  final List<WebtoonEpisodeModel> episodes;
  final String webtoonId;

  const EpisodeWidget({
    super.key,
    required this.episodes,
    required this.webtoonId,
  });

  // 🚀 에피소드 이동 함수
  void _onEpisodeTap(String episodeId) async {
    int parseEpId = int.parse(episodeId) + 1;
    String epId = parseEpId.toString();
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$epId");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var episode in episodes)
          Column(
            children: [
              GestureDetector(
                onTap: () => _onEpisodeTap(episode.id),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Image.network(
                          episode.thumb,
                          // 추가하는이유: 네이버가 제공하는 이미지를 브라우저가 아닌 곳에서 사용하기 위해
                          headers: const {
                            "User-Agent":
                                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episode.title,
                          style: const TextStyle(
                            fontFamily: "SBAggro",
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "⭐️ ${episode.rating}",
                          style: TextStyle(
                            fontFamily: "SBAggro",
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
      ],
    );
  }
}
