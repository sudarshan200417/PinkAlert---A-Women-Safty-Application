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
          //Background
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


          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = contactList![index];

                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
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
                                      await FlutterPhoneDirectCaller    //phone call
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