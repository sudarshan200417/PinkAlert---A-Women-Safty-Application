//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/chat_module/chat_screen.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// import '../child/child_login_screen.dart';
//
// class ParentHomeScreen extends StatelessWidget {
//   const ParentHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: Column(
//           children: [
//             DrawerHeader(
//               child: Container(
//                 child: Image.asset(
//                   'assets/logo.png',
//                   fit: BoxFit.cover,
//                   height: 30,
//                 ),
//               ),
//             ),
//             ListTile(
//                 title: TextButton(
//                     onPressed: () async {
//                       try {
//                         await FirebaseAuth.instance.signOut();
//                         goTo(context, LoginScreen());
//                       } on FirebaseAuthException catch (e) {
//                         dialogueBox(context, e.toString());
//                       }
//                     },
//                     child: Text(
//                       "Log out",
//                     ))),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white, // makes the hamburger icon white
//         ),
//         backgroundColor:  Color(0xFFF67280),
//         // backgroundColor: Color.fromARGB(255, 250, 163, 192),
//         title: Text("Select Child",
//           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .where('type', isEqualTo: 'child')
//             .where('guardiantEmail',
//             isEqualTo: FirebaseAuth.instance.currentUser!.email)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: progressIndicator(context));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               final d = snapshot.data!.docs[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   color: Color.fromARGB(255, 250, 163, 192),
//                   child: ListTile(
//                     onTap: () {
//                       goTo(
//                           context,
//                           ChatScreen(
//                               currentUserId:
//                               FirebaseAuth.instance.currentUser!.uid,
//                               friendId: d.id,
//                               friendName: d['name']));
//                     },
//                     title: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(d['name']),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/chat_module/chat_screen.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/profile_page.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/review_page.dart';
import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

import '../child/child_login_screen.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final parentEmail = MySharedPreferences.getUserEmail();

    print("Parent Email: $parentEmail");

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF67280),
              ),
              child: Center(
                child: const Text(
                  "PinkAlert",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Image.asset(
              'assets/logo.png',
              height: 130,
              width: 130,
            ),

            const SizedBox(height: 40),

            // 🔹 Profile
            ListTile(
              leading: const Icon(Icons.person, color: Colors.red),
              title: const Text("Profile"),
              onTap: () {
                goTo(context, ProfilePage());
              },
            ),

            // 🔹 Reviews
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.red),
              title: const Text("Reviews"),
              onTap: () {
                goTo(context, ReviewPage());
              },
            ),

            // 🔹 Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  await MySharedPreferences.clearAll(); // ✅ clear session
                  goTo(context, LoginScreen());
                } catch (e) {
                  dialogueBox(context, e.toString());
                }
              },
            ),
          ],
        ),
      ),

      // 🔹 AppBar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFFF67280),
        elevation: 3,
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
      ),

      // 🔹 BODY
      body: Stack(
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg_image.png'),
                fit: BoxFit.contain,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          // 🔹 Content
          parentEmail == null
              ? const Center(
            child: Text("User not logged in"),
          )
              : StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('type', isEqualTo: 'child')
                .where('guardiantEmail', isEqualTo: parentEmail)
                .snapshots(),
            builder: (context, snapshot) {

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No children found"),
                );
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final d = docs[index];

                  return Card(
                    color: Colors.white.withOpacity(0.9),
                    elevation: 4,
                    margin:
                    const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding:
                      const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),

                      // 🔹 Avatar
                      leading: CircleAvatar(
                        backgroundColor:
                        const Color(0xFFF67280),
                        child: Text(
                          d['name'] != null &&
                              d['name'].isNotEmpty
                              ? d['name'][0]
                              .toUpperCase()
                              : "?",
                          style: const TextStyle(
                              color: Colors.white),
                        ),
                      ),

                      // 🔹 Name
                      title: Text(
                        d['name'] ?? "No Name",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),

                      // 🔹 Navigation
                      onTap: () {
                        goTo(
                          context,
                          ChatScreen(
                            currentUserId:
                            FirebaseAuth.instance
                                .currentUser!.uid,
                            friendId: d.id,
                            friendName: d['name'],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
