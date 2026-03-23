import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe/BusStationCard.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe/HospitalCard.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe/PharmacyCard.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/live_safe/PoliceStationCard.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    final encodedLocation = Uri.encodeComponent(location);

    // Prefer using geo: scheme (opens in Google Maps app directly)
    final Uri geoUri = Uri.parse('geo:0,0?q=$encodedLocation');

    try {
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(
          geoUri,
          mode: LaunchMode.externalApplication,
        );
        return;
      }

      final Uri webUri = Uri.parse('https://www.google.com/maps/search/$encodedLocation');
      if (await canLaunchUrl(webUri)) {
        await launchUrl(
          webUri,
          mode: LaunchMode.externalApplication,
        );
        return;
      }

      // If both fail, show message
      Fluttertoast.showToast(
        msg: 'Could not open Maps. Please check your device settings.',
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong! Please call an emergency number.',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          HospitalCard(onMapFunction: openMap),
          PoliceStationCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}

