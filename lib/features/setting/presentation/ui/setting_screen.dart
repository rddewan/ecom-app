
import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/common/class/set_pass_code_screen.dart';
import 'package:ecom_app/common/class/show_pass_code_screen.dart';
import 'package:ecom_app/core/local/db/hive_box_key.dart';
import 'package:ecom_app/features/setting/presentation/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseConsumerState<SettingScreen> with SetPassCodeScreen, ShowPassCodeScreen {

  @override
  void initState() {    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(settingControllerProvider.notifier).getPassCodeFromBox(passCodeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final passCode = ref.watch(settingControllerProvider.select((value) => value.passCode));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Enable PassCode'),
            subtitle: const Text('enable / disable your PassCode'),
            trailing: Switch.adaptive(
              value: passCode == null ? false : true, 
              onChanged: (value) {
                if (value) {
                  _setPassCode();
                }
                else {
                  _showPassCode();
                }

              },
            ),
          )

        ],
      ),
    );
    
  }

  void _showPassCode() {
    final correctString = ref.read(settingControllerProvider).passCode ?? '';

    showPassCode(
      context, 
      correctString: correctString, 
      didUnlocked: () {
        ref.read(settingControllerProvider.notifier).addPassCodeToBox(passCodeKey, null);
        Navigator.of(context).pop();
      },
    );
  }

  void _setPassCode() {
    final inputController = InputController();
    setPassCode(
      context, 
      inputController: inputController,
      didConfirmed: (matchedText) {
        ref.read(settingControllerProvider.notifier).addPassCodeToBox(passCodeKey, matchedText);
        Navigator.of(context).pop();
      },
      footer: TextButton(
        onPressed: () {
          inputController.unsetConfirmed();
        }, 
        child: const Text('Clear and Return to enter mode', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}