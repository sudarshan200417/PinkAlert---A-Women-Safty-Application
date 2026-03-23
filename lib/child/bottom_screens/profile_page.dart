// // import 'package:flutter/material.dart';
// //
// // class ProfilePage extends StatelessWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(child: Text('Profile Page')),
// //     );
// //   }
// // }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'package:women_safety_tracking_system/child/bottom_page.dart';
// import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/components/custom_textfield.dart';
// import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
//
// class CheckUserStatusBeforeChatOnProfile extends StatelessWidget {
//   const CheckUserStatusBeforeChatOnProfile({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else {
//           if (snapshot.hasData) {
//             return ProfilePage();
//           } else {
//             Fluttertoast.showToast(msg: 'please login first');
//             return LoginScreen();
//           }
//         }
//       },
//     );
//   }
// }
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   TextEditingController nameC = TextEditingController();
//   TextEditingController guardianEmailC = TextEditingController();
//   TextEditingController childEmailC = TextEditingController();
//   TextEditingController phoneC = TextEditingController();
//
//   final key = GlobalKey<FormState>();
//   String? id;
//   String? profilePic;
//   String? downloadUrl;
//   bool isSaving = false;
//   getDate() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         nameC.text = value.docs.first['name'];
//         childEmailC.text = value.docs.first['childEmail'];
//         guardianEmailC.text = value.docs.first['guardiantEmail'];
//         phoneC.text = value.docs.first['phone'];
//         id = value.docs.first.id;
//         profilePic = value.docs.first['profilePic'];
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getDate();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: isSaving == true
//           ? Center(
//           child: CircularProgressIndicator(
//             backgroundColor: Colors.pink,
//           ))
//           : SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Center(
//             child: Form(
//                 key: key,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "UPDATE YOUR PROFILE",
//                       style: TextStyle(
//                           fontSize: 25,
//                         fontWeight: FontWeight.w800,
//                         color:Color(0xFFf67280),
//                       ),
//                     ),
//                     SizedBox(height: 7),
//                     GestureDetector(
//                       onTap: () async {
//                         final XFile? pickImage = await ImagePicker()
//                             .pickImage(
//                             source: ImageSource.gallery,
//                             imageQuality: 50);
//                         if (pickImage != null) {
//                           setState(() {
//                             profilePic = pickImage.path;
//                           });
//                         }
//                       },
//                       child: SingleChildScrollView(
//                         child: Container(
//                           child: profilePic == null
//                               ? CircleAvatar(
//                             backgroundColor: Color(0xFFf67280),
//                             radius: 80,
//                             child: Center(
//                                 child: Image.asset(
//                                   'assets/add_pic.png',
//                                   height: 80,
//                                   width: 80,
//                                 )),
//                           )
//                               : profilePic!.contains('http')
//                               ? CircleAvatar(
//                             backgroundColor: Colors.deepPurple,
//                             radius: 80,
//                             backgroundImage:
//                             NetworkImage(profilePic!),
//                           )
//                               : CircleAvatar(
//                               backgroundColor: Colors.deepPurple,
//                               radius: 80,
//                               backgroundImage:
//                               FileImage(File(profilePic!))),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       controller: nameC,
//                       hintText: nameC.text,
//                       validate: (v) {
//                         if (v!.isEmpty) {
//                           return 'please enter your updated name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       controller: childEmailC,
//                       hintText: "child email",
//                       readOnly: true,
//                       validate: (v) {
//                         if (v!.isEmpty) {
//                           return 'please enter your updated name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       controller: guardianEmailC,
//                       hintText: "parent email",
//                       readOnly: true,
//                       validate: (v) {
//                         if (v!.isEmpty) {
//                           return 'please enter your updated name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       controller: phoneC,
//                       hintText: "Phone number",
//                       readOnly: true,
//                       validate: (v) {
//                         if (v!.isEmpty) {
//                           return 'please enter your updated name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 25),
//                     PrimaryButton(
//                         title: "UPDATE",
//                         onPressed: () async {
//                           if (key.currentState!.validate()) {
//                             SystemChannels.textInput
//                                 .invokeMethod('TextInput.hide');
//                             profilePic == null
//                                 ? Fluttertoast.showToast(
//                                 msg: 'please select profile picture')
//                                 : update();
//                           }
//                         })
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<String?> uploadImage(String filePath) async {
//     try {
//       final filenName = Uuid().v4();
//       final Reference fbStorage =
//       FirebaseStorage.instance.ref('profile').child(filenName);
//       final UploadTask uploadTask = fbStorage.putFile(File(filePath));
//       await uploadTask.then((p0) async {
//         downloadUrl = await fbStorage.getDownloadURL();
//       });
//       return downloadUrl;
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   update() async {
//     setState(() {
//       isSaving = true;
//     });
//     uploadImage(profilePic!).then((value) {
//       Map<String, dynamic> data = {
//         'name': nameC.text,
//         'profilePic': downloadUrl,
//       };
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update(data);
//       setState(() {
//         isSaving = false;
//         goTo(context, BottomPage());
//       });
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_tracking_system/child/bottom_page.dart';
import 'package:women_safety_tracking_system/child/child_login_screen.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/components/custom_textfield.dart';
import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class CheckUserStatusBeforeChatOnProfile extends StatelessWidget {
  const CheckUserStatusBeforeChatOnProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return const ProfilePage();
          } else {
            Fluttertoast.showToast(msg: 'Please login first');
            return LoginScreen();
          }
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController guardianEmailC = TextEditingController();
  TextEditingController childEmailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  final key = GlobalKey<FormState>();
  String? id;
  bool isSaving = false;

  getDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        var data = value.docs.first.data();
        setState(() {
          nameC.text = data['name'] ?? '';
          childEmailC.text = data['childEmail'] ?? '';
          guardianEmailC.text =
              data['guardianEmail'] ?? data['guardiantEmail'] ?? '';
          phoneC.text = data['phone'] ?? '';
          id = value.docs.first.id;
        });
      }
    }).catchError((error) {
      print('Error fetching data: $error');
      Fluttertoast.showToast(msg: 'Error loading profile data');
    });
  }

  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg_image.png'),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                  Colors.white54,
                  BlendMode.lighten,
                ),
              ),
            ),
          ),

          SafeArea(
            child: isSaving
                ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            )
                : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      color: Colors.white.withOpacity(0.9),
                      //color: const Color(0xFFF3D1DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: key,
                          child: Column(
                            children: [
                              const Text(
                                "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFf67280),
                                ),
                              ),
                              const SizedBox(height: 25),
                              CustomTextField(
                                controller: nameC,
                                hintText: "Name",
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                controller: childEmailC,
                                hintText: "Child email",
                                readOnly: true,
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                controller: guardianEmailC,
                                hintText: "Parent email",
                                readOnly: true,
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                controller: phoneC,
                                hintText: "Phone number",
                                readOnly: true,
                              ),
                              const SizedBox(height: 25),
                              PrimaryButton(
                                title: "Update",
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                    updateNameOnly();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🌸 3. Logout button on top
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFf67280),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    await MySharedPreferences.clearAll();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false,
                    );
                  },
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: Colors.white, size: 20),
                        SizedBox(width: 6),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  updateNameOnly() async {
    setState(() {
      isSaving = true;
    });

    Map<String, dynamic> data = {
      'name': nameC.text,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);

    setState(() {
      isSaving = false;
    });

    Fluttertoast.showToast(msg: 'Profile name updated successfully!');
    goTo(context, const BottomPage());
  }
}
