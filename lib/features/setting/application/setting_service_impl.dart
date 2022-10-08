
import 'package:ecom_app/features/setting/application/setting_service.dart';
import 'package:ecom_app/features/setting/data/repository/setting_repository.dart';
import 'package:ecom_app/features/setting/data/repository/setting_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingServiceProvider = Provider<SettingService>((ref) {
  final settingRepository = ref.watch(settingRepositoryProvider);

  return SettingServiceImpl(settingRepository);

});

class SettingServiceImpl implements SettingService {
  final SettingRepository _settingRepository;

  SettingServiceImpl(this._settingRepository);

  

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    final result = await _settingRepository.addToBox(key, value);

    return result;
    
  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    return await _settingRepository.getFromBox(key);    
  }

}