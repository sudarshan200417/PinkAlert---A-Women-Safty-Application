//This is the Actual Code
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/add_contacts.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/chat_page.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/child_home_page.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/profile_page.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/review_page.dart';
//
// class BottomPage extends StatefulWidget {
//   const BottomPage({super.key});
//
//   @override
//   State<BottomPage> createState() => _BottomPageState();
// }
//
// class _BottomPageState extends State<BottomPage> {
//   int currentIndex = 0;
//
//   final List<Widget> pages = [
//     HomeScreen(),
//     ChatPage(),
//     AddContactsPage(),
//     ProfilePage(),
//     ReviewPage(),
//   ];
//
//
//   String getAppBarTitle() {
//     switch (currentIndex) {
//       case 1:
//         return "Chat";
//       case 2:
//         return "Emergency Contacts";
//       case 3:
//         return "Profile";
//       case 4:
//         return "Reviews";
//       default:
//         return "PinkAlert";
//     }
//   }
//
//   void onTapped(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 offset: Offset(0, 4),
//                 blurRadius: 8,
//               ),
//             ],
//           ),
//           child: AppBar(
//             centerTitle: true,
//             title: ShaderMask(
//               shaderCallback: (bounds) => const LinearGradient(
//                 colors: [Colors.white, Colors.white70],
//               ).createShader(bounds),
//               child: Text(
//                 getAppBarTitle(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 24,
//                   letterSpacing: 2.0,
//                 ),
//               ),
//             ),
//             elevation: 0,
//             backgroundColor: const Color(0xFFf67280),
//           ),
//         ),
//       ),
//
//       body: pages[currentIndex],
//
//       // 🌸 Bottom Navigation
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           child: BottomNavigationBar(
//             currentIndex: currentIndex,
//             type: BottomNavigationBarType.fixed,
//             onTap: onTapped,
//             backgroundColor: Colors.white,
//             selectedItemColor: const Color(0xFFf67280),
//             unselectedItemColor: const Color(0xFFFF8A9A),
//             showUnselectedLabels: true,
//             selectedFontSize: 14,
//             unselectedFontSize: 12,
//             iconSize: 28,
//             items: const [
//               BottomNavigationBarItem(
//                 label: 'Home',
//                 icon: Icon(Icons.home),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Chat',
//                 icon: Icon(Icons.chat),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Contacts',
//                 icon: Icon(Icons.call),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Profile',
//                 icon: Icon(Icons.person),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Reviews',
//                 icon: Icon(Icons.reviews),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/add_contacts.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/chat_page.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/child_home_page.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/profile_page.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/review_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;

  //make pages const (important for stability)
  final List<Widget> pages = [
    HomeScreen(),
    ChatPage(),
    AddContactsPage(),
    ProfilePage(),
    ReviewPage(),
  ];

  String getAppBarTitle() {
    switch (currentIndex) {
      case 1:
        return "Chat";
      case 2:
        return "Emergency Contacts";
      case 3:
        return "Profile";
      case 4:
        return "Reviews";
      default:
        return "PinkAlert";
    }
  }

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: AppBar(
            centerTitle: true,
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Colors.white70],
              ).createShader(bounds),
              child: Text(
                getAppBarTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: const Color(0xFFf67280),
          ),
        ),
      ),

     
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: onTapped,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFf67280),
            unselectedItemColor: const Color(0xFFFF8A9A),
            showUnselectedLabels: true,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(Icons.chat),
              ),
              BottomNavigationBarItem(
                label: 'Contacts',
                icon: Icon(Icons.call),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                label: 'Reviews',
                icon: Icon(Icons.reviews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}