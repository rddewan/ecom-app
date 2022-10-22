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


### Flutter Fire
```
flutterfire config \
  --project=flutter-ecomapp-dev-c7f8b \
  --out=lib/core/firebase/firebase_options_dev.dart \
  --ios-bundle-id=dev.rdewan.ecomApp.development \     
  --android-package-name=dev.rdewan.ecomApp.development  

  flutterfire config \
  --project=flutter-ecomapp-qa-92e63 \  
  --out=lib/core/firebase/firebase_options_qa.dart \  
  --ios-bundle-id=dev.rdewan.ecomApp.qa \      
  --android-package-name=dev.rdewan.ecomApp.qa 

  flutterfire config \
  --project=flutter-ecomapp-uat-e3721 \ 
  --out=lib/core/firebase/firebase_options_uat.dart \ 
  --ios-bundle-id=dev.rdewan.ecomApp.uat \     
  --android-package-name=dev.rdewan.ecomApp.uat

  flutterfire config \
  --project=flutter-ecomapp-prod-34d00 \
  --out=lib/core/firebase/firebase_options_prod.dart \
  --ios-bundle-id=dev.rdewan.ecomApp \
  --android-package-name=dev.rdewan.ecomApp
  
  ```