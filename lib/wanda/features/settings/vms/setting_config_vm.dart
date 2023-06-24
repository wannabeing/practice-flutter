import 'package:flutter/material.dart';
import 'package:may230517/wanda/features/settings/models/setting_config_model.dart';
import 'package:may230517/wanda/features/settings/repos/setting_config_repo.dart';

class SettingConfigViewModel extends ChangeNotifier {
  final SettingConfigRepository _repository; // 로컬저장소
  // 로컬저장소 값으로 세팅설정모델 생성 및 초기화
  late final SettingConfigModel _model = SettingConfigModel(
    videoMute: _repository.getVideoMute(),
    videoAutoplay: _repository.getVideoAutoplay(),
    darkTheme: _repository.getDarkTheme(),
  );

  // =============================================
  // ✅ 생성자 (생성시, 로컬저장소 초기화)
  // =============================================

  SettingConfigViewModel(this._repository);

  // =============================================
  // 🚀 세팅설정모델 값 GET 함수
  // =============================================

  bool get getConfigVideoMute => _model.videoMute;
  bool get getConfigVideoAutoplay => _model.videoAutoplay;
  bool get getConfigDarkTheme => _model.darkTheme;

  // =============================================
  // 🚀 사용자에게 받은 값을 모델/로컬저장소에 저장(SET) 함수
  // =============================================

  Future<void> setVideoMute(bool value) async {
    await _repository.setVideoMute(value); // 로컬저장소에 저장
    _model.videoMute = value; // 세팅설정모델에 저장
    notifyListeners(); // 값 변경 views에 notify
  }

  Future<void> setVideoAutoplay(bool value) async {
    await _repository.setVideoAutoplay(value); // 로컬저장소에 저장
    _model.videoAutoplay = value; // 세팅설정모델에 저장
    notifyListeners(); // 값 변경 views에 notify
  }

  Future<void> setDarkTheme(bool value) async {
    await _repository.setDarkTheme(value); // 로컬저장소에 저장
    _model.darkTheme = value; // 세팅설정모델에 저장
    notifyListeners(); // 값 변경 views에 notify
  }
}
