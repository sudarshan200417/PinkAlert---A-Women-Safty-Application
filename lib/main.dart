// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/child/bottom_page.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/child_home_page.dart';
// import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
// import 'package:women_safety_tracking_system/parent/parent_home_screen.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
// import 'firebase_options.dart';
//
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//     await MySharedPreferences.init();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'women safety',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//      // textTheme:
//         primarySwatch: Colors.blue,
//
//       ),
//       home:FutureBuilder(
//           future: MySharedPreferences.getUserType(),
//           builder: (BuildContext context,AsyncSnapshot snapshot){
//             if(snapshot.data == ""){
//               return LoginScreen();
//             }
//             if(snapshot.data == "child"){
//               return BottomPage();
//             }
//             if(snapshot.data == "parent"){
//               return ParentHomeScreen();
//             }
//               return progressIndicator(context);
//           },
//       )
//     );
//   }
// }
//
// // class CheckAuth extends StatelessWidget {
// //   //const CheckAuth({super.key});
// //    checkData(){
// //      if(MySharedPreferences.getUserType()=='parent'){
// //
// //      }
// //    }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold();
// //   }
// // }
//
//
//
//
//
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   try {
// //     await Firebase.initializeApp();
// //   } catch (e) {
// //     print('Firebase initialization error: $e');
// //   }
// //
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Women Safety',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: LoginScreen(),
// //     );
// //   }
// // }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:women_safety_tracking_system/child/bottom_page.dart';
// import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
// import 'package:women_safety_tracking_system/parent/parent_home_screen.dart';
// import 'package:women_safety_tracking_system/utils/flutter_background_services.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await MySharedPreferences.init();
//   //initializeService();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //title: 'women safety',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder(
//         future: MySharedPreferences.getUserType(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           // Show loading while checking
//           if (snapshot.connectionState == ConnectionState.waiting ||
//               snapshot.data == null) {
//             return Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//
//           // User not logged in
//           if (snapshot.data == "") {
//             return LoginScreen();
//           }
//
//           // Child user
//           if (snapshot.data == "child") {
//             return BottomPage();
//           }
//
//           // Parent user
//           if (snapshot.data == "parent") {
//             return ParentHomeScreen();
//           }
//
//           // Default fallback - if data is something unexpected
//           return LoginScreen();
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/child/bottom_page.dart';
import 'package:women_safety_tracking_system/child/child_login_screen.dart';
import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
import 'package:women_safety_tracking_system/parent/parent_home_screen.dart';
import 'firebase_options.dart';

/// 🔴 CHANGE 1: Make main async + preload userType
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await MySharedPreferences.init();

  /// 🔴 IMPORTANT: Fetch before UI builds
  String userType = await MySharedPreferences.getUserType() ?? "";

  runApp(MyApp(userType: userType));
}

/// 🔴 CHANGE 2: Pass userType into MyApp
class MyApp extends StatelessWidget {
  final String userType;

  const MyApp({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// 🔴 CHANGE 3: Direct routing instead of FutureBuilder
      home: _getHomeScreen(),
    );
  }

  /// 🔴 CHANGE 4: Clean routing logic
  Widget _getHomeScreen() {
    if (userType == "") {
      return LoginScreen();
    } else if (userType == "child") {
      return BottomPage();
    } else if (userType == "parent") {
      return ParentHomeScreen();
    } else {
      return LoginScreen();
    }
  }
}