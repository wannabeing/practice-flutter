import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:may230517/webtoon/models/webtoon.dart';
import 'package:may230517/webtoon/models/webtoon_detail.dart';
import 'package:may230517/webtoon/models/webtoon_episode.dart';

class WebtoonApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  // 🚀 오늘의 웹툰 리스트 가져오기
  static Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoons = []; // 반환할 웹툰 리스트

    final getUrl = Uri.parse('$baseUrl/today'); // http request URL
    final result = await http.get(getUrl); // GET request 결과

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

  // 🚀 웹툰 상세정보 가져오기
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final getUrl = Uri.parse('$baseUrl/$id'); // http request URL
    final result = await http.get(getUrl); // GET request 결과

    if (result.statusCode == 200) {
      final webtoon = WebtoonDetailModel.fromJson(
        jsonDecode(result.body),
      ); // String(result.body) -> json 디코딩(jsonDecode) -> webtoonDetailModel
      return webtoon; // 변환한 WebtoonDetailModel 변환
    }

    throw Error();
  }

  // 🚀 웹툰 에피소드 가져오기
  static Future<List<WebtoonEpisodeModel>> getEpisodesBy(String id) async {
    List<WebtoonEpisodeModel> episodes = []; // 반환할 에피소드 리스트
    final getUrl = Uri.parse('$baseUrl/$id/episodes'); // http request URL
    final result = await http.get(getUrl); // GET request 결과

    if (result.statusCode == 200) {
      final episodeList = jsonDecode(result.body); // String -> json디코딩

      for (var episodeJson in episodeList) {
        final episode =
            WebtoonEpisodeModel.fromJson(episodeJson); // json -> webtoon Model
        episodes.add(episode); // 에피소드 리스트에 추가
      }
      return episodes; // 변환한 array return
    }

    return episodes; // 빈 array return
  }
}
