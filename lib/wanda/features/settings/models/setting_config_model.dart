// ✅ 설정 모델
class SettingConfigModel {
  bool videoMute; // 비디오 음소거 여부
  bool videoAutoplay; // 비디오 자동재생 여부
  bool darkTheme; // 다크테마 여부

  SettingConfigModel({
    required this.videoMute,
    required this.videoAutoplay,
    required this.darkTheme,
  });
}
