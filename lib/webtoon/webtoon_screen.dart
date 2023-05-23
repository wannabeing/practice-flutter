import 'package:flutter/material.dart';
import 'package:may230517/services/webtoon_api_service.dart';
import 'package:may230517/webtoon/models/webtoon.dart';

import 'widgets/webtoon_widget.dart';

class WebtoonScreen extends StatelessWidget {
  WebtoonScreen({super.key});

  // ✅ 비동기처리 데이터
  final Future<List<WebtoonModel>> webtoons = WebtoonApiService.getTodayToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "웹툰 페이지",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SBAggro",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 1,
      ),
      body: FutureBuilder(
        future: webtoons, // Future 데이터
        builder: (context, snapshot) {
          // snapshot: 데이터의 상태
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: webtoonList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }

  // 웹툰 정보를 반환하는 ListView
  ListView webtoonList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 30,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonWidget(
          id: webtoon.id,
          title: webtoon.title,
          thumb: webtoon.thumb,
        );
      },
    );
  }
}
