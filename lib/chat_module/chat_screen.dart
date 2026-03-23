// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:women_safety_tracking_system/chat_module/message_text_field.dart';
// import 'package:women_safety_tracking_system/chat_module/singleMessage.dart';
//
// import '../utils/constants.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   final String friendId;
//   final String friendName;
//
//   const ChatScreen(
//       {super.key,
//         required this.currentUserId,
//         required this.friendId,
//         required this.friendName});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   String? type;
//   String? myname;
//
//   getStatus() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.currentUserId)
//         .get()
//         .then((value) {
//       setState(() {
//         type = value.data()!['type'];
//
//         myname = value.data()!['name'];
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     getStatus();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFFF67280),
//           title: Text(widget.friendName),
//         ),
//         body: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: const AssetImage('assets/Bg_image.png'),
//                   repeat: ImageRepeat.repeat,
//                   fit: BoxFit.contain,
//                   alignment: Alignment.topCenter,
//                   colorFilter: ColorFilter.mode(
//                     Colors.white.withOpacity(0.5),
//                     BlendMode.lighten,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(widget.currentUserId)
//                     .collection('messages')
//                     .doc(widget.friendId)
//                     .collection('chats')
//                     .orderBy('date', descending: false)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     if (snapshot.data!.docs.length < 1) {
//                       return Center(
//                         child: Text(
//                           type == "Parent"
//                               ? "TALK WITH CHILD"
//                               : "TALK WITH PARENT",
//                           style: TextStyle(fontSize: 30),
//                         ),
//                       );
//                     }
//                     return Container(
//                       child: ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           bool isMe = snapshot.data!.docs[index]['senderId'] ==
//                               widget.currentUserId;
//                           final data = snapshot.data!.docs[index];
//                           return Dismissible(
//                             key: UniqueKey(),
//                             onDismissed: (direction) async {
//                               await FirebaseFirestore.instance
//                                   .collection('users')
//                                   .doc(widget.currentUserId)
//                                   .collection('messages')
//                                   .doc(widget.friendId)
//                                   .collection('chats')
//                                   .doc(data.id)
//                                   .delete();
//                               await FirebaseFirestore.instance
//                                   .collection('users')
//                                   .doc(widget.friendId)
//                                   .collection('messages')
//                                   .doc(widget.currentUserId)
//                                   .collection('chats')
//                                   .doc(data.id)
//                                   .delete()
//                                   .then((value) => Fluttertoast.showToast(
//                                   msg: 'message deleted successfully'));
//                             },
//
//                               child: SingleMessage(
//                                 message: data['message'],
//                                 date: data['date'],
//                                 isMe: isMe,
//                                 friendName: widget.friendName,
//                                 myName: myname,
//                                 type: data['type'],
//                               ),
//
//                           );
//                         },
//                       ),
//                     );
//                   }
//                   return progressIndicator(context);
//                 },
//               ),
//             ),
//             MessageTextField(
//               currentId: widget.currentUserId,
//               friendId: widget.friendId,
//             ),
//           ],
//         )
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_tracking_system/chat_module/message_text_field.dart';
import 'package:women_safety_tracking_system/chat_module/singleMessage.dart';

import '../utils/constants.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String type = "";
  String myname = "";

  /// Get user status safely
  Future<void> getStatus() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data =
        snapshot.data() as Map<String, dynamic>?;

        setState(() {
          type = data?['type'] ?? "";
          myname = data?['name'] ?? "";
        });
      }
    } catch (e) {
      debugPrint("Error loading user status: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF67280),
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    title: Text(widget.friendName,
    style: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
        ),
      ),
      ),

      body: Stack(
        children: [

          /// Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/Bg_image.png'),
                fit: BoxFit.contain,
                repeat: ImageRepeat.repeat,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),

          /// Chat UI
          Column(
            children: [

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentUserId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy('date', descending: false)
                      .snapshots(),

                  builder: (context, snapshot) {

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return progressIndicator(context);
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          type == "Parent"
                              ? "Talk with Child!!!"
                              : "Talk with Parent!!!",
                          style: const TextStyle(fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data!.docs.length,

                      itemBuilder: (context, index) {

                        final data =
                        snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                        bool isMe =
                            data['senderId'] == widget.currentUserId;

                        return Dismissible(
                          key: Key(snapshot.data!.docs[index].id),

                          onDismissed: (direction) async {

                            try {

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentUserId)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .collection('chats')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.friendId)
                                  .collection('messages')
                                  .doc(widget.currentUserId)
                                  .collection('chats')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();

                              Fluttertoast.showToast(
                                  msg: "Message deleted");

                            } catch (e) {
                              debugPrint("Delete error: $e");
                            }
                          },

                          child: SingleMessage(
                            message: data['message'] ?? "",
                            date: data['date'],
                            isMe: isMe,
                            friendName: widget.friendName,
                            myName: myname,
                            type: data['type'] ?? "text",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              /// Message input field
              MessageTextField(
                currentId: widget.currentUserId,
                friendId: widget.friendId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}