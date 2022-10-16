# ecom_app

A new Flutter project.

## Getting Started


##  flutter_flavorizr
When you finished defining the flavorizr configuration, you can proceed by running the script with:
```
flutter pub run flutter_flavorizr
```

## Build Android release app
* fvm flutter build apk --release --obfuscate --split-debug-info=build/app/symbols --build-name=1.0.0 --build-number=1 --flavor dev -t lib/main_dev.dart



## Build iOS release app
* fvm flutter build ipa --release  --obfuscate --split-debug-info=build/ios/symbols --export-options-plist build/ios/export_options.plist --build-name=1.0.0 --build-number=1 --flavor prod -t lib/main_prod.dart


## KeyTool 
* Keytool -list -v -keystore dewan.jks -alias dewan

### The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using 
* "keytool -importkeystore -srckeystore android/keystores/dewan.jks -destkeystore android/keystores/dewan.jks -deststoretype pkcs12"

## Build Runner
* fvm flutter  pub run build_runner build --delete-conflicting-outputs
* fvm flutter  pub run build_runner clean