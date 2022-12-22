

import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {

  const factory SettingState({    
    String? passCode,
    String? accessToken,
    int? userId,

  }) = _SettingState;

}