import 'package:shared_preferences/shared_preferences.dart';

class SettingConfigRepository {
  // 로컬저장소 KEY 이름
  static const String _videoMute = "videoMute";
  static const String _videoAutoplay = "videoAutoplay";
  static const String _darkTheme = "darkTheme";

  final SharedPreferences _sharedPreferences; // 디바이스 로컬 저장소

  // =============================================
  // ✅ 생성자 (생성시, SharedPreferences 초기화)
  // =============================================
  SettingConfigRepository(this._sharedPreferences);

  // =============================================
  // 🚀 로컬저장소 저장(SET) 함수
  // =============================================

  Future<void> setVideoMute(bool value) async {
    await _sharedPreferences.setBool(_videoMute, value);
  }

  Future<void> setVideoAutoplay(bool value) async {
    await _sharedPreferences.setBool(_videoAutoplay, value);
  }

  Future<void> setDarkTheme(bool value) async {
    await _sharedPreferences.setBool(_darkTheme, value);
  }

  // =============================================
  // 🚀 로컬저장소 가져오기(GET) 함수
  // =============================================

  // 기본 값 false (음소거 하지 않음)
  bool getVideoMute() {
    return _sharedPreferences.getBool(_videoMute) ?? false;
  }

  // 기본 값 true (자동재생 설정)
  bool getVideoAutoplay() {
    return _sharedPreferences.getBool(_videoAutoplay) ?? true;
  }

  // 기본 값 false (다크모드 사용하지 않음)
  bool getDarkTheme() {
    return _sharedPreferences.getBool(_darkTheme) ?? false;
  }
}
