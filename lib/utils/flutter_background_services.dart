//
// import 'dart:async';
// import 'dart:ui';
//
// import 'package:background_location/background_location.dart';
// //import 'package:background_sms/background_sms.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// //import 'package:geolocator/geolocator.dart';
// import 'package:shake/shake.dart';
// import 'package:telephony/telephony.dart';
// import 'package:vibration/vibration.dart';
// import 'package:women_safety_tracking_system/db/db_services.dart';
// import 'package:women_safety_tracking_system/model/contactsm.dart';
//
// sendMessage(String messageBody) async {
//   List<TContact> contactList = await DatabaseHelper().getContactList();
//   if (contactList.isEmpty) {
//     Fluttertoast.showToast(msg: "no number exist please add a number");
//   } else {
//     for (var i = 0; i < contactList.length; i++) {
//       Telephony.backgroundInstance
//           .sendSms(to: contactList[i].number, message: messageBody)
//           .then((value) {
//         Fluttertoast.showToast(msg: "message send");
//       });
//     }
//   }
// }
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "script academy",
//     "foreground service",
//     "used for imp notifcation",
//     importance: Importance.low,
//   );
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//       iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: true,
//         autoStart: true,
//         notificationChannelId: "script academy",
//         initialNotificationTitle: "foreground service",
//         initialNotificationContent: "initializing",
//         foregroundServiceNotificationId: 888,
//       ));
//   service.startService();
// }
//
// @pragma('vm-entry-point')
// void onStart(ServiceInstance service) async {
//   Location? clocation;
//
//   DartPluginRegistrant.ensureInitialized();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   await BackgroundLocation.setAndroidNotification(
//     title: "Location tracking is running in the background!",
//     message: "You can turn it off from settings menu inside the app",
//     icon: '@mipmap/ic_logo',
//   );
//   BackgroundLocation.startLocationService(
//     distanceFilter: 20,
//   );
//
//   BackgroundLocation.getLocationUpdates((location) {
//     clocation = location;
//   });
//   if (service is AndroidServiceInstance) {
//     if (await service.isForegroundService()) {
//       // await Geolocator.getCurrentPosition(
//       //         desiredAccuracy: LocationAccuracy.high,
//       //         forceAndroidLocationManager: true)
//       //     .then((Position position) {
//       //   _curentPosition = position;
//       //   print("bg location ${position.latitude}");
//       // }).catchError((e) {
//       //   //Fluttertoast.showToast(msg: e.toString());
//       // });
//
//       ShakeDetector.autoStart(
//           shakeThresholdGravity: 7,
//           shakeSlopTimeMS: 500,
//           shakeCountResetTime: 3000,
//           minimumShakeCount: 1,
//           onPhoneShake: () async {
//             if (await Vibration.hasVibrator() ?? false) {
//               print("Test 2");
//               if (await Vibration.hasCustomVibrationsSupport() ?? false) {
//                 print("Test 3");
//                 Vibration.vibrate(duration: 1000);
//               } else {
//                 print("Test 4");
//                 Vibration.vibrate();
//                 await Future.delayed(Duration(milliseconds: 500));
//                 Vibration.vibrate();
//               }
//               print("Test 5");
//             }
//             String messageBody =
//                 "https://www.google.com/maps/search/?api=1&query=${clocation!.latitude}%2C${clocation!.longitude}";
//             sendMessage(messageBody);
//           });
//
//       flutterLocalNotificationsPlugin.show(
//         888,
//         "women safety app",
//         clocation == null
//             ? "please enable location to use app"
//             : "shake feature enable ${clocation!.latitude}",
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//               "script academy",
//               "foregrounf service",
//               "used for imp notifcation",
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             )),
//       );
//     }
//   }
// }
import 'dart:async';
import 'dart:ui';

import 'package:background_location/background_location.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import 'package:women_safety_tracking_system/db/db_services.dart';
import 'package:women_safety_tracking_system/model/contactsm.dart';

/// ================= SEND SMS =================

Future<void> sendMessage(String messageBody) async {
  List<TContact> contactList = await DatabaseHelper().getContactList();

  if (contactList.isEmpty) {
    Fluttertoast.showToast(msg: "No emergency contacts found");
    return;
  }

  final Telephony telephony = Telephony.instance;
  bool? permission = await telephony.requestPhoneAndSmsPermissions;

  for (var contact in contactList) {
    try {
      telephony.sendSms(
        to: contact.number,
        message: messageBody,
      );
    } catch (e) {
      print("SMS failed → fallback");
      telephony.sendSmsByDefaultApp(
        to: contact.number,
        message: messageBody,
      );
    }
  }

  Fluttertoast.showToast(msg: "SOS Triggered!");
}

/// ================= CALL (RELIABLE) =================

Future<void> makeCall(String number) async {
  final Uri uri = Uri(scheme: 'tel', path: number);
  await launchUrl(uri);
}

/// ================= INITIALIZE SERVICE =================

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'script_academy',
    'Foreground Service',
    description: 'Safety monitoring active',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: 'script_academy',
      initialNotificationTitle: 'PinkAlert Active',
      initialNotificationContent: 'Safety service running',
      foregroundServiceNotificationId: 888,
    ),
  );
}

/// ================= SERVICE START =================

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Location? clocation;

  print("✅ Background service started");

  /// 🔴 Start location tracking
  await BackgroundLocation.setAndroidNotification(
    title: "Location tracking active",
    message: "Your safety service is running",
    icon: '@mipmap/ic_launcher',
  );

  BackgroundLocation.startLocationService(distanceFilter: 20);

  BackgroundLocation.getLocationUpdates((location) {
    clocation = location;
  });

  /// 🔴 SHAKE DETECTOR
  ShakeDetector.autoStart(
    shakeThresholdGravity: 7,
    onPhoneShake: () async {
      print("📳 Shake detected (background)");

      if (clocation == null) {
        print("❌ Location not ready");
        return;
      }

      /// vibration
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 800);
      }

      String message =
          "🚨 EMERGENCY!\nhttps://maps.google.com/?q=${clocation!.latitude},${clocation!.longitude}";

      await sendMessage(message);

      /// 🔴 ALSO CALL (VERY IMPORTANT)
      List<TContact> contacts = await DatabaseHelper().getContactList();
      if (contacts.isNotEmpty) {
        await makeCall(contacts.first.number);
      }
    },
  );

  /// 🔴 FOREGROUND NOTIFICATION LOOP
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        String text = (clocation == null)
            ? "Waiting for location..."
            : "Tracking: ${clocation!.latitude}, ${clocation!.longitude}";

        flutterLocalNotificationsPlugin.show(
          888,
          "PinkAlert Active",
          text,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'script_academy',
              'Foreground Service',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}