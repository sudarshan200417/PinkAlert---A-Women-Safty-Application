import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/chat_module/chat_screen.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // 🌸 Background
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/Bg_image.png'),
              repeat: ImageRepeat.repeat,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.lighten,
              ),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [

              // ✅ FIX: Added Expanded
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where("type", isEqualTo: "Parent")
                      .where(
                    "childEmail",
                    isEqualTo: FirebaseAuth.instance.currentUser!.email,
                  )
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final d = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                //color: Color(0xFFF3D1DD),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    goTo(
                                        context,
                                        ChatScreen(
                                            currentUserId:
                                            FirebaseAuth.instance.currentUser!.uid,
                                            friendId: d.id,
                                            friendName: d['name']));
                                  },
                                  title: Text(
                                    d['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFFF67280),
                                    child: Text(
                                      d['name'][0].toUpperCase(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                                ),
                              ),
                            )
                        );
                      },
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}