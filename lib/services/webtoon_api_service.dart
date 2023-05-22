import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:may230517/webtoon/models/webtoon.dart';

class WebtoonApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoons = []; // 반환할 웹툰 리스트
    final todayUrl = Uri.parse('$baseUrl/today'); // http request URL
    final result = await http.get(todayUrl); // GET request 결과

    if (result.statusCode == 200) {
      final list = jsonDecode(result.body); // String -> json디코딩

      for (var jsonWebtoon in list) {
        final webtoon =
            WebtoonModel.fromJson(jsonWebtoon); // json -> webtoon Model
        webtoons.add(webtoon); // 웹툰 리스트에 추가
      }
      return webtoons; // 변환한 array return
    }
    return webtoons; // 빈 array return
  }
}
