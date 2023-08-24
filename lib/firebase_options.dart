// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBD5p7-jw2t0P2StaZsQf4VegwY7FlkkIM',
    appId: '1:718753448548:web:0be59af95d8ecf3b129571',
    messagingSenderId: '718753448548',
    projectId: 'firstfirebase-bead3',
    authDomain: 'firstfirebase-bead3.firebaseapp.com',
    storageBucket: 'firstfirebase-bead3.appspot.com',
    measurementId: 'G-M41T88NL63',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfYwjG1IQbjqLPNkBLh-RXUy4zUYLFYwI',
    appId: '1:718753448548:android:6c53f167e4b37e56129571',
    messagingSenderId: '718753448548',
    projectId: 'firstfirebase-bead3',
    storageBucket: 'firstfirebase-bead3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaGWpSI6G1aIWxyfZJTPRPLlFVfMEASBk',
    appId: '1:718753448548:ios:3b095fe079821f28129571',
    messagingSenderId: '718753448548',
    projectId: 'firstfirebase-bead3',
    storageBucket: 'firstfirebase-bead3.appspot.com',
    iosClientId: '718753448548-vpktmk2j8l2sho1kmo7gch9t8ssfgdkh.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseExample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaGWpSI6G1aIWxyfZJTPRPLlFVfMEASBk',
    appId: '1:718753448548:ios:1eb28be07861de4b129571',
    messagingSenderId: '718753448548',
    projectId: 'firstfirebase-bead3',
    storageBucket: 'firstfirebase-bead3.appspot.com',
    iosClientId: '718753448548-a5lhpo4eogc078jgkrs3eutllr14maa0.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseExample.RunnerTests',
  );
}