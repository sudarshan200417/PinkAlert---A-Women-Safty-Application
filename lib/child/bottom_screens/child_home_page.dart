// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:women_safety_tracking_system/widgets/home_widgets/CustomCarouel.dart';
// // import 'package:women_safety_tracking_system/widgets/home_widgets/custom_appBar.dart';
// // import 'package:women_safety_tracking_system/widgets/home_widgets/emergency.dart';
// // import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe.dart';
// // import 'package:women_safety_tracking_system/widgets/home_widgets/safehome/SafeHome.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //  //const HomeScreen({super.key});
// // int qindex=2;
// //
// // getRandomQuote(){
// //   Random random = Random();
// //
// //   setState(() {
// //     qindex = random.nextInt(6);
// //   });
// // }
// // @override
// //   void initState() {
// //      getRandomQuote();
// //     // TODO: implement initState
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //      body: SafeArea(
// //        child: Padding(
// //          padding: const EdgeInsets.all(8.0),
// //          child: Column(
// //            children: [
// //              CustomAppBar(
// //                quoteIndex: qindex,
// //                onTap:(){
// //                  getRandomQuote();
// //                }
// //              ),
// //              Expanded(
// //                  child: ListView(
// //                    shrinkWrap: true,
// //                    children: [
// //                      CustomCarouel(),
// //                      Padding(
// //                        padding: const EdgeInsets.all(8.0),
// //                        child: Text("Emergency Callers",
// //                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
// //                        ),
// //                      ),
// //                      Emergency(),
// //                      Padding(
// //                        padding: const EdgeInsets.all(8.0),
// //                        child: Text("Explore LiveSafe",
// //                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
// //                        ),
// //                      ),
// //                      LiveSafe(),
// //                      SafeHome(),
// //                    ],
// //                  )
// //              ),
// //            ],
// //          ),
// //        ),
// //      ),
// //     );
// //   }
// // }
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/CustomCarouel.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/custom_appBar.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/emergency.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/safehome/SafeHome.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int qindex = 2;
//
//   getRandomQuote() {
//     Random random = Random();
//     setState(() {
//       qindex = random.nextInt(6);
//     });
//   }
//
//   @override
//   void initState() {
//     getRandomQuote();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: const AssetImage('assets/Bg_image.png'),
//                 repeat: ImageRepeat.repeat,
//                 fit: BoxFit.contain,
//                 alignment: Alignment.topCenter,
//                 colorFilter: ColorFilter.mode(
//                   Colors.white.withOpacity(0.6), // soft transparent look
//                   BlendMode.lighten,
//                 ),
//               ),
//             ),
//           ),
//
//           // 🌸 Foreground UI content
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   CustomAppBar(
//                     quoteIndex: qindex,
//                     onTap: () {
//                       getRandomQuote();
//                     },
//                   ),
//                   Expanded(
//                     child: ListView(
//                       shrinkWrap: true,
//                       children: [
//                         CustomCarouel(),
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             "Emergency Callers",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                         Emergency(),
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             "Explore LiveSafe",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                         LiveSafe(),
//                         SafeHome(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//this is the original code
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:telephony/telephony.dart';
// import 'package:women_safety_tracking_system/db/db_services.dart';
// import 'package:women_safety_tracking_system/model/contactsm.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/CustomCarouel.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/custom_appBar.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/emergency.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe.dart';
// import 'package:women_safety_tracking_system/widgets/home_widgets/safehome/SafeHome.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   int qIndex = 0;
//
//   Position? _currentPosition;
//
//   final Telephony telephony = Telephony.instance;
//
//   /// 🔴 SHAKE VARIABLES
//   late StreamSubscription accelerometerSubscription;
//   double shakeThreshold = 20.0;
//   DateTime lastShakeTime = DateTime.now();
//
//   /// ================= PERMISSIONS =================
//
//   Future<void> _getPermission() async {
//     await Permission.sms.request();
//     await Permission.location.request();
//   }
//
//   /// ================= LOCATION =================
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       setState(() {
//         _currentPosition = position;
//       });
//
//     } catch (e) {
//       print("Location error: $e");
//     }
//   }
//
//   ///  SMS
//
//   Future<void> getAndSendSms() async {
//
//     if (_currentPosition == null) {
//       Fluttertoast.showToast(msg: "Getting location...");
//       await _getCurrentLocation();
//     }
//
//     List<TContact> contactList = await DatabaseHelper().getContactList();
//
//     String message =
//         "I am in trouble Help ME!\nLocation:\nhttps://maps.google.com/?q=${_currentPosition!.latitude},${_currentPosition!.longitude}";
//
//     bool? permission = await telephony.requestPhoneAndSmsPermissions;
//
//     if (permission == true) {
//
//       for (var contact in contactList) {
//
//         /// 🔴 TRY SILENT SMS
//         telephony.sendSms(
//           to: contact.number,
//           message: message,
//           statusListener: (status) {
//             print("SMS STATUS: $status");
//           },
//         );
//
//         /// 🔴 FALLBACK (ALWAYS WORKS)
//         telephony.sendSmsByDefaultApp(
//           to: contact.number,
//           message: message,
//         );
//       }
//
//       Fluttertoast.showToast(msg: "SOS Triggered!");
//
//     } else {
//       Fluttertoast.showToast(msg: "SMS Permission Denied");
//     }
//   }
//
//   /// SHAKE
//
//   void initShakeDetector() {
//     accelerometerSubscription = accelerometerEvents.listen((event) {
//
//       double acceleration = sqrt(
//         event.x * event.x +
//             event.y * event.y +
//             event.z * event.z,
//       );
//
//       if (acceleration > shakeThreshold) {
//         final now = DateTime.now();
//
//         if (now.difference(lastShakeTime).inSeconds > 2) {
//           lastShakeTime = now;
//
//           print("Shake detected!");
//
//           _getCurrentLocation();
//
//           Future.delayed(Duration(seconds: 2), () {
//             getAndSendSms();
//           });
//         }
//       }
//     });
//   }
//
//   /// QUOTES
//
//   void getRandomQuote() {
//     Random random = Random();
//     setState(() {
//       qIndex = random.nextInt(6);
//     });
//   }
//
//   /// INIT
//
//   @override
//   void initState() {
//     super.initState();
//
//     getRandomQuote();
//     _getPermission();
//     initShakeDetector();
//   }
//
//   @override
//   void dispose() {
//     accelerometerSubscription.cancel();
//     super.dispose();
//   }
//
//   /// UI
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           /// 🌸 BACKGROUND IMAGE
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/Bg_image.png'),
//                 repeat: ImageRepeat.repeat,
//                 fit: BoxFit.contain,
//                 alignment: Alignment.topCenter,
//                 colorFilter: ColorFilter.mode(
//                   Colors.white.withOpacity(0.6),
//                   BlendMode.lighten,
//                 ),
//               ),
//             ),
//           ),
//
//           /// 🌸 FOREGROUND UI
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//
//               child: Column(
//                 children: [
//
//                   CustomAppBar(
//                     quoteIndex: qIndex,
//                     onTap: () {
//                       getRandomQuote();
//                     },
//                   ),
//
//                   Expanded(
//                     child: ListView(
//                       children: [
//
//                         /// 🔼 FIRST
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Explore Your Power",
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         CustomCarouel(),
//
//                         /// 🔽 SECOND
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Emergency Callers",
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Emergency(),
//
//                         /// 🔽 THIRD
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Explore LiveSafe",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black54,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         LiveSafe(),
//                         SafeHome(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:women_safety_tracking_system/db/db_services.dart';
import 'package:women_safety_tracking_system/model/contactsm.dart';
import 'package:women_safety_tracking_system/utils/flutter_background_services.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/CustomCarouel.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/custom_appBar.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/emergency.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/safehome/SafeHome.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int qIndex = 0;

  Position? _currentPosition;
  final Telephony telephony = Telephony.instance;

  /// 🔴 SHAKE VARIABLES
  late StreamSubscription accelerometerSubscription;
  double shakeThreshold = 20.0;
  DateTime lastShakeTime = DateTime.now();

  /// 🔴 UI READY FLAG
  bool isReady = false;

  /// ================= SERVICE =================

  Future<void> startSafetyService() async {
    await [
      Permission.location,
      Permission.sms,
      Permission.phone,
      Permission.notification,
    ].request();

    await initializeService();
    FlutterBackgroundService().startService();

    print("✅ Background service started");
  }

  /// ================= LOCATION =================

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
      });

    } catch (e) {
      print("Location error: $e");
    }
  }

  /// ================= SMS =================

  Future<void> getAndSendSms() async {

    if (_currentPosition == null) {
      Fluttertoast.showToast(msg: "Getting location...");
      await _getCurrentLocation();
    }

    List<TContact> contactList = await DatabaseHelper().getContactList();

    String message =
        "I am in trouble Help ME!\nLocation:\nhttps://maps.google.com/?q=${_currentPosition!.latitude},${_currentPosition!.longitude}";

    bool? permission = await telephony.requestPhoneAndSmsPermissions;

    if (permission == true) {

      for (var contact in contactList) {

        telephony.sendSms(
          to: contact.number,
          message: message,
        );

        telephony.sendSmsByDefaultApp(
          to: contact.number,
          message: message,
        );
      }

      Fluttertoast.showToast(msg: "SOS Triggered!");

    } else {
      Fluttertoast.showToast(msg: "SMS Permission Denied");
    }
  }

  /// ================= SHAKE =================

  void initShakeDetector() {
    accelerometerSubscription = accelerometerEvents.listen((event) {

      double acceleration = sqrt(
        event.x * event.x +
            event.y * event.y +
            event.z * event.z,
      );

      if (acceleration > shakeThreshold) {
        final now = DateTime.now();

        if (now.difference(lastShakeTime).inSeconds > 2) {
          lastShakeTime = now;

          print("Shake detected!");

          _getCurrentLocation();

          Future.delayed(const Duration(seconds: 2), () {
            getAndSendSms();
          });
        }
      }
    });
  }

  /// ================= QUOTES =================

  void getRandomQuote() {
    qIndex = Random().nextInt(6); // ❌ removed setState
  }

  /// ================= INIT =================

  @override
  void initState() {
    super.initState();

    getRandomQuote();

    /// 🔴 FIX: delay heavy work
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startSafetyService();
      initShakeDetector();

      setState(() {
        isReady = true;
      });
    });
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();
    super.dispose();
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {

    /// 🔴 FIX: prevent broken first render
    if (!isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [

          /// 🌸 BACKGROUND IMAGE
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg_image.png'),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),

          /// 🌸 FOREGROUND UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: Column(
                children: [

                  CustomAppBar(
                    quoteIndex: qIndex,
                    onTap: () {
                      setState(() {
                        getRandomQuote();
                      });
                    },
                  ),

                  Expanded(
                    child: ListView(
                      children: [

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Explore Your Power",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        CustomCarouel(),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Emergency Callers",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Emergency(),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Explore LiveSafe",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        LiveSafe(),
                        SafeHome(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}