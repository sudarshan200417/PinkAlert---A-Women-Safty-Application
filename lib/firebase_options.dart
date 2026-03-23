import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqDGEksgnT7vMdqCYUJGqk2jzCuhtYDRI',  // Get from google-services.json -> current_key
    appId: '1:688516803971:android:678afe7dd4c8d1e3fe1ab6',    // Get from google-services.json -> mobilesdk_app_id
    messagingSenderId: '688516803971',  // Get from google-services.json -> project_number
    projectId: 'u-61b12',  // Get from google-services.json -> project_id
  );
}