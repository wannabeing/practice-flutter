import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/settings/models/setting_config_model.dart';
import 'package:may230517/wanda/features/settings/repos/setting_config_repo.dart';

class SettingConfigViewModel extends Notifier<SettingConfigModel> {
  final SettingConfigRepository _repository; // 로컬저장소
  SettingConfigViewModel(this._repository); // main.dart에서 초기화

  // =============================================
  // 🚀 사용자에게 받은 값을 모델/로컬저장소에 저장(SET) 함수
  // =============================================

  Future<void> setConfigVideoMute(bool value) async {
    await _repository.setVideoMute(value); // 로컬저장소에 저장
    // 새로운 Notifier 세팅모델로 덮어쓰기
    state = SettingConfigModel(
      videoMute: value,
      videoAutoplay: state.videoAutoplay,
      darkTheme: state.darkTheme,
    );
  }

  Future<void> setConfigVideoAutoplay(bool value) async {
    await _repository.setVideoAutoplay(value); // 로컬저장소에 저장
    // 새로운 Notifier 세팅모델로 덮어쓰기
    state = SettingConfigModel(
      videoMute: state.videoMute,
      videoAutoplay: value,
      darkTheme: state.darkTheme,
    );
  }

  Future<void> setConfigDarkTheme(bool value) async {
    await _repository.setDarkTheme(value); // 로컬저장소에 저장
    // 새로운 Notifier 세팅모델로 덮어쓰기
    state = SettingConfigModel(
      videoMute: state.videoMute,
      videoAutoplay: state.videoAutoplay,
      darkTheme: value,
    );
  }

  // =============================================
  // ✅ 빌드 메소드 (초기값 반환)
  // =============================================
  @override
  SettingConfigModel build() {
    return SettingConfigModel(
      videoMute: _repository.getVideoMute(),
      videoAutoplay: _repository.getVideoAutoplay(),
      darkTheme: _repository.getDarkTheme(),
    );
  }
}

// 로컬저장소는 main.dart에서 초기화하기 때문에 해당 Throw Error
final settingConfigProvider =
    NotifierProvider<SettingConfigViewModel, SettingConfigModel>(
  () => throw UnimplementedError(),
);
