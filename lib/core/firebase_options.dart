// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyD5l-iSGfjGLEPT0oh5hSv0JiR0ZpxqboM',
//     appId: '1:431209683654:web:0b85b17348b300c875d5c7',
//     messagingSenderId: '431209683654',
//     projectId: 'twitter-clone-bb9de',
//     authDomain: 'twitter-clone-bb9de.firebaseapp.com',
//     storageBucket: 'twitter-clone-bb9de.appspot.com',
//     measurementId: 'G-RDC64DVN43',
//   );

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyBcOSHjJ83BI-kopCIMLD7ZhH3CxAIpMzI',
//     appId: '1:431209683654:android:cbac1cb3826e4b1575d5c7',
//     messagingSenderId: '431209683654',
//     projectId: 'twitter-clone-bb9de',
//     storageBucket: 'twitter-clone-bb9de.appspot.com',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyDqBjUV4I5Grsed7BycS4lU_4V81lPNeKI',
//     appId: '1:431209683654:ios:b217b464336e3fec75d5c7',
//     messagingSenderId: '431209683654',
//     projectId: 'twitter-clone-bb9de',
//     storageBucket: 'twitter-clone-bb9de.appspot.com',
//     iosBundleId: 'com.example.flutterTwitter',
//   );
// }
