import 'dart:io';

class AdHelper {



  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7523426678948885/9089201190';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7523426678948885/3034389739';
    }
    throw UnsupportedError("Unsupported platform");
  }
}