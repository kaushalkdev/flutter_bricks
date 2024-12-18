// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9LdpTgN5L3dSre26iReyCtw2LJsN-sT8',
    appId: '1:1000216542766:android:9c0bf99723ae3adc20e9bf',
    messagingSenderId: '1000216542766',
    projectId: 'base-flutter-app-a90c7',
    storageBucket: 'base-flutter-app-a90c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlDet1CgOUuy1Kb-BzYosVcsmoIZ8M7KE',
    appId: '1:1000216542766:ios:5aed818c2b982f4920e9bf',
    messagingSenderId: '1000216542766',
    projectId: 'base-flutter-app-a90c7',
    storageBucket: 'base-flutter-app-a90c7.appspot.com',
    androidClientId: '1000216542766-fs0u8jon6ql0nnuli0lhq8tujjnkbsrf.apps.googleusercontent.com',
    iosClientId: '1000216542766-n9qe8u707r5drig69sk33lup4opsnmua.apps.googleusercontent.com',
    iosBundleId: 'com.example.baseApp',
  );
}
