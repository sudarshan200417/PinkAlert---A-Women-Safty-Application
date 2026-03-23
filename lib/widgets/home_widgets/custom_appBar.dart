import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/utils/quotes.dart';

class CustomAppBar extends StatelessWidget{
  // const CustomAppBar({super.key});
Function? onTap;
int? quoteIndex;
CustomAppBar({this.onTap, this.quoteIndex});
  @override
  Widget build(BuildContext context){
    return
      GestureDetector(
        onTap: (){
          onTap!();
        },
        child: Container(
          child: Text(sweetSayings[quoteIndex!],
              style:TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              fontSize: 22,
          )
          ),

        ),
      );

  }
}