import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/services/webtoon_api_service.dart';
import 'package:may230517/webtoon/models/webtoon_detail.dart';
import 'package:may230517/webtoon/models/webtoon_episode.dart';
import 'package:may230517/webtoon/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebtoonDetailScreen extends StatefulWidget {
  final String id, title, thumb;

  const WebtoonDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<WebtoonDetailScreen> createState() => _WebtoonDetailScreenState();
}

class _WebtoonDetailScreenState extends State<WebtoonDetailScreen> {
  // ✅ 비동기처리 데이터
  late Future<WebtoonDetailModel> detail =
      WebtoonApiService.getToonById(widget.id);

  late Future<List<WebtoonEpisodeModel>> episodes =
      WebtoonApiService.getEpisodesBy(widget.id);

  // ✅ 휴대폰에 데이터 저장 변수
  late SharedPreferences prefs;

  bool isLike = false;

  // 🚀 웹툰 좋아요 클릭 함수
  Future<void> _onHeartTap({required String webtoonId}) async {
    final likeToons = prefs.getStringList('likeToons');

    if (likeToons == null) return;

    // 좋아요 상태에서 눌렀을 경우
    if (isLike) {
      likeToons.remove(webtoonId); // 삭제
    } else {
      likeToons.add(webtoonId); // 추가
    }
    // 상태 변경
    await prefs.setStringList('likeToons', likeToons);
    setState(() {
      isLike = !isLike;
    });
  }

  // 🚀 prefs 초기화 함수
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likeToons = prefs.getStringList('likeToons');

    if (likeToons != null) {
      // 좋아요리스트 안에 웹툰ID 있는지 확인
      if (likeToons.contains(widget.id)) {
        setState(() {
          isLike = true;
        });
      }
    }
    // 좋아요리스트가 없으면 생성
    else {
      await prefs.setStringList('likeToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    _initPrefs(); // prefs 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "SBAggro",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _onHeartTap(webtoonId: widget.id),
            icon: FaIcon(
              isLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            ),
          ),
        ],
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: widget.id,
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
                                widget.thumb,
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
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: detail,
                      builder: (context, snapshot) {
                        // ✅ Future 웹툰 상세 정보
                        if (snapshot.hasData) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                    const SizedBox(
                      height: 50,
                    ),
                    FutureBuilder(
                      future: episodes,
                      builder: (context, snapshot) {
                        // ✅ Future 웹툰 에피소드 정보
                        if (snapshot.hasData) {
                          return EpisodeWidget(
                              webtoonId: widget.id, episodes: snapshot.data!);
                        }
                        return const CircularProgressIndicator.adaptive();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
