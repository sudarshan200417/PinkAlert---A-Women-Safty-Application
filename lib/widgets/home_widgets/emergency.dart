import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/Emergenies/AmbulanceEmergency.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/Emergenies/ArmyEmergency.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/Emergenies/FirebrigadeEmergency.dart';
import 'package:women_safety_tracking_system/widgets/home_widgets/Emergenies/PoliceEmergency.dart';


class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
          ArmyEmergency(),
        ],
      ),
    );
  }
}