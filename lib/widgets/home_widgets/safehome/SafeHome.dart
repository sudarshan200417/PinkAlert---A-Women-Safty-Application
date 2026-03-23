// import 'package:background_sms/background_sms.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/model/contactsm.dart';
// import '../../../db/db_services.dart';
// class SafeHome extends StatefulWidget {
//   @override
//   State<SafeHome> createState() => _SafeHomeState();
// }
//
// class _SafeHomeState extends State<SafeHome> {
//   Position? _currentPosition;
//   String? _currentAddress;
//   LocationPermission? permission;
//
//   _getPermission() async => await [Permission.sms].request();
//
//   _isPermissionGranted() async => await Permission.sms.status.isGranted;
//
//   _sendSms(String phoneNumber, String message, {int? simSlot}) async {
//     await BackgroundSms.sendMessage(
//       phoneNumber: phoneNumber,
//       message: message,
//       simSlot: 1,
//     ).then((SmsStatus status) {
//       if (status == "sent") {
//         Fluttertoast.showToast(msg: "Message is sent");
//       } else {
//         Fluttertoast.showToast(msg: "Message is Failed to send");
//       }
//     });
//   }
//
//   _getCurrentLocation() async {
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       Fluttertoast.showToast(msg: "Location permission denied");
//       if (permission == LocationPermission.deniedForever) {
//         Fluttertoast.showToast(msg: "Location Permission Permanently denied");
//       }
//     }
//     Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//       forceAndroidLocationManager: true,
//     ).then((Position position) {
//       setState(() {
//         _currentPosition = position;
//         _getAddressFromLatLong();
//       });
//     }).catchError((e){
//       Fluttertoast.showToast(msg:e.toString());
//
//     });
//   }
//   _getAddressFromLatLong() async {
//     try{
//       List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress="${place.locality},${place.postalCode},${place.street},${place.name},";
//       });
//     }catch(e){
//      Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
// @override
// void initState(){
//     super.initState();
//     _getPermission();
//     _getCurrentLocation();
// }
//   showModelSafeHome(BuildContext context) {
//     showBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height / 1.9,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Send your Current Location to your Emergency Contacts",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 if(_currentPosition != null) Text(_currentAddress!),
//                 SizedBox(height: 15),
//                 PrimaryButton(title: "Get Location", onPressed: () {
//                   _getCurrentLocation();
//                 }),
//                 SizedBox(height: 10),
//                 PrimaryButton(title: "Send Alert", onPressed: () async {
//                   List<TContact> contactList = await DatabaseHelper().getContactList();
//                   String recipients = "";
//                   int i =1;
//                   for(TContact contact in contactList){
//                     recipients += contact.number;
//                     if(i!=contactList.length){
//                       recipients +=";";
//                       i++;
//                     }
//                   }
//
//                   String messageBody="https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}. $_currentAddress";
//
//                   if(await _isPermissionGranted()){
//                     contactList.forEach((element) {
//                       _sendSms("${element.number}","please reach me out As soon As possible my current location is $messageBody",simSlot: 1);
//                     });
//                   }else{
//                     Fluttertoast.showToast(msg: "something went wrong");
//                   }
//                 }),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // ✅ NOW INSIDE the class
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => showModelSafeHome(context),
//       child: Card(
//         color: Colors.pink[50],
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           height: 180,
//           width: MediaQuery.of(context).size.width * 0.7,
//           decoration: BoxDecoration(),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Text("Send Location"),
//                       subtitle: Text("Share Location"),
//                     ),
//                   ],
//                 ),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset('assets/route.jpg'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/model/contactsm.dart';
import '../../../db/db_services.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {

  Position? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  // ============================
  // REQUEST LOCATION PERMISSION
  // ============================
  Future<void> _requestLocationPermission() async {
    await Permission.location.request();
  }

  // ============================
  // GET CURRENT LOCATION
  // ============================
  Future<void> _getCurrentLocation() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Enable location services");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Permission permanently denied");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
    });

    await _getAddressFromLatLong(position);
  }

  // ============================
  // GET ADDRESS FROM LAT LONG
  // ============================
  Future<void> _getAddressFromLatLong(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.street}";
      });

    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to fetch address");
    }
  }

  // ============================
  // SEND ALERT USING DEFAULT SMS APP
  // ============================
  Future<void> _sendAlert() async {

    if (_currentPosition == null) {
      Fluttertoast.showToast(msg: "Please get location first");
      return;
    }

    List<TContact> contactList =
    await DatabaseHelper().getContactList();

    if (contactList.isEmpty) {
      Fluttertoast.showToast(msg: "No emergency contacts found");
      return;
    }

    String message =
        "🚨 EMERGENCY ALERT 🚨\n\n"
        "I need help.\n"
        "My location:\n"
        "https://www.google.com/maps/search/?api=1&query="
        "${_currentPosition!.latitude},"
        "${_currentPosition!.longitude}\n\n"
        "$_currentAddress";

    for (var contact in contactList) {

      final Uri smsUri = Uri(
        scheme: 'sms',
        path: contact.number,
        queryParameters: {'body': message},
      );

      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        Fluttertoast.showToast(
            msg: "Could not open SMS app");
      }
    }
  }

  // ============================
  // BOTTOM SHEET
  // ============================
  void showModelSafeHome(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Send your Current Location to Emergency Contacts",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 20),

                if (_currentAddress != null)
                  Text(
                    _currentAddress!,
                    textAlign: TextAlign.center,
                  ),

                SizedBox(height: 20),

                PrimaryButton(
                  title: "Get Location",
                  onPressed: _getCurrentLocation,
                ),

                SizedBox(height: 15),

                PrimaryButton(
                  title: "Send Location",
                  onPressed: _sendAlert,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================
  // ORIGINAL CARD UI (UNCHANGED DESIGN)
  // ============================
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        color: Colors.pink[50],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text("Send Location"),
                      subtitle: Text(
                        _currentAddress ?? "Share Location",
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/route.jpg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}