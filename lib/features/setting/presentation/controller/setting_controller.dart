


import 'package:ecom_app/core/local/db/hive_box_key.dart';
import 'package:ecom_app/features/setting/application/setting_service.dart';
import 'package:ecom_app/features/setting/application/setting_service_impl.dart';
import 'package:ecom_app/features/setting/presentation/state/setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingControllerProvider = StateNotifierProvider<SettingController,SettingState>((ref) {
  final settingService = ref.watch(settingServiceProvider);

  return SettingController(settingService, const SettingState());
});

class SettingController extends StateNotifier<SettingState> {
  final SettingService _settingService;

  SettingController(this._settingService, super.state);

  void addPassCodeToBox(String key, String? value) async {
    final result = await _settingService.addToBox<String>(key, value);
    if (result) {
      state = state.copyWith(passCode: value);
    }
  }

  void getPassCodeFromBox(String key) async{
    final result = await _settingService.getFromBox<String>(key);
    state = state.copyWith(passCode: result);
  } 

  void getUserIdFromBox() async{
    final result = await _settingService.getFromBox<int?>(userIdKey);
    state = state.copyWith(userId: result);
  }

  void getAccessTokenFromBox() async{
    final result = await _settingService.getFromBox<String?>(accessTokenKey);
    state = state.copyWith(accessToken: result);
  }  
}