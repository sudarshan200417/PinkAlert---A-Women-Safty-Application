// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:women_safety_tracking_system/child/bottom_screens/contacts_page.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/db/db_services.dart';
// import 'package:women_safety_tracking_system/model/contactsm.dart';
//
// class AddContactsPage extends StatefulWidget {
//   const AddContactsPage({super.key});
//
//   @override
//   State<AddContactsPage> createState() => _AddContactsPageState();
// }
//
// class _AddContactsPageState extends State<AddContactsPage> {
//   DatabaseHelper databasehelper = DatabaseHelper();
//   List<TContact>? contactList;
//   int count = 0;
//
//   void showList() {
//     Future<Database> dbFuture = databasehelper.initializeDatabase();
//     dbFuture.then((database) {
//       Future<List<TContact>> contactListFuture = databasehelper.getContactList();
//       contactListFuture.then((value) {
//         setState(() {
//           contactList = value;
//           count = value.length;
//         });
//       });
//     });
//   }
//
//   void deleteContact(TContact contact) async {
//     int result = await databasehelper.deleteContact(contact.id);
//     if (result != 0) {
//       Fluttertoast.showToast(msg: "Contact removed successfully");
//       showList();
//     }
//   }
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showList();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     contactList ??= [];
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 🌸 Full-screen repeated pattern background
//           Container(
//             // width: double.infinity,
//             // height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: const AssetImage('assets/Bg_image.png'),
//                 repeat: ImageRepeat.repeat,
//                 fit: BoxFit.contain,
//                 alignment: Alignment.topCenter,
//                 colorFilter: ColorFilter.mode(
//                   Colors.white.withOpacity(0.5),
//                   BlendMode.lighten,
//                 ),
//               ),
//             ),
//           ),
//
//           // 🌸 Foreground UI
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: count,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Card(
//                             color: Colors.white.withOpacity(0.9),
//                           //color: const Color(0xFFF3D1DD), // soft pinkish white card
//                           elevation: 4,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 6, horizontal: 4),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               leading: (contact.avatar != null &&
//                                   contact.avatar!.isNotEmpty)
//                                   ? CircleAvatar(
//                                 backgroundImage:
//                                 MemoryImage(
//                                     contact.avatar!),
//                               )
//                                   : CircleAvatar(
//                                 backgroundColor:
//                                 Colors.pink[100],
//                                 child: Text(
//                                     contact.initials()),
//                               ),
//                               title: Text(
//                                 contactList![index].name,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               trailing: SizedBox(
//                                 width: 100,
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () async {
//                                         await FlutterPhoneDirectCaller.callNumber(
//                                             contactList![index].number);
//                                       },
//                                       icon: const Icon(Icons.call,
//                                           color: Colors.green),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         deleteContact(contactList![index]);
//                                       },
//                                       icon: const Icon(Icons.delete,
//                                           color: Colors.red),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   PrimaryButton(
//                     title: "+",
//
//                     onPressed: () async {
//                       bool result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ContactsPage(),
//                         ),
//                       );
//                       if (result == true) {
//                         showList();
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // class AddContactsPage extends StatefulWidget {
// //   //const AddContactsPage({super.key});
// //
// //   @override
// //   State<AddContactsPage> createState() => _AddContactsPageState();
// // }
// //
// // class _AddContactsPageState extends State<AddContactsPage> {
// //   DatabaseHelper databaseHelper = DatabaseHelper();
// //   List<TContact>? contactList;
// //   int count=0;
// //
// //  void showList(){
// //     Future<Database>dbFuture=databaseHelper.initializeDatabase();
// //     dbFuture.then((database){
// //      Future<List<TContact>> contactListFuture = databaseHelper.getContactList();
// //      contactListFuture.then((value){
// //        setState(() {
// //          this.contactList = value;
// //          this.count=value.length;
// //        });
// //      });
// //     });
// //   }
// //
// //   void deleteContact(TContact contact) async{
// //     int result=await databaseHelper.deleteContact(contact.id);
// //     if(result!=0){
// //       Fluttertoast.showToast(msg: "Contact Removed Successfully");
// //       showList();
// //     }
// //   }
// //
// //
// //
// //
// //   @override
// //   void initState() {
// //    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //      showList();
// //    });
// //     super.initState();
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //    if(contactList==null){
// //      contactList=[];
// //    }
// //     return SafeArea(
// //       child: Container(
// //         padding: EdgeInsets.all(12),
// //         child: Column(
// //           children: [
// //             PrimaryButton(title: "Add  Contacts",
// //             onPressed:() async{
// //             bool result = await Navigator.push(context,MaterialPageRoute(builder:(context)=>ContactsPage()));
// //             if(result==true){
// //               showList();
// //             }
// //             }),
// //             SizedBox(height: 10,),
// //             Expanded(
// //               child: ListView.builder(
// //                 //shrinkWrap: true,
// //                  itemCount: count,
// //                   itemBuilder:(BuildContext context, int index){
// //                    return Card(
// //                      child: ListTile(
// //                        title: Text(contactList![index].name),
// //                        trailing: IconButton(onPressed: (){
// //                          deleteContact(contactList![index]);
// //                        },
// //                     icon:Icon(Icons.delete,color: Colors.red,
// //                          ),
// //                      ),
// //                    ),
// //                    );
// //                   }
// //               ),
// //             ),
// //   ],
// //       ),
// //     ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:women_safety_app/child/bottom_screens/contacts_page.dart';
// // import 'package:women_safety_app/components/PrimaryButton.dart';
// // import 'package:women_safety_app/db/db_services.dart';
// // import 'package:women_safety_app/model/contactsm.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/contacts_page.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/db/db_services.dart';
import 'package:women_safety_tracking_system/model/contactsm.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
      databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          contactList = value;
          count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact removed successfully");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contactList ??= [];

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background
          Container(
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

          // 🔹 UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = contactList![index]; // ✅ FIX

                       // Uint8List? avatarBytes = contact.avatar;

                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            // 🔹 Circular Avatar FIXED
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.pink[100],
                              child: Text(
                                contact.name.isNotEmpty
                                    ? contact.name
                                    .trim()
                                    .split(" ")
                                    .map((e) => e[0])
                                    .take(2)
                                    .join()
                                    .toUpperCase()
                                    : "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            title: Text(
                              contact.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller
                                          .callNumber(contact.number);
                                    },
                                    icon: const Icon(Icons.call,
                                        color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteContact(contact);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔹 Add Contact Button
                  PrimaryButton(
                    title: "+",
                    onPressed: () async {
                      bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactsPage(),
                        ),
                      );
                      if (result == true) {
                        showList();
                      }
                    },
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}