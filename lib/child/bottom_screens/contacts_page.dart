// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({super.key});
//
//   @override
//   State<ContactsPage> createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//  List<Contact> contacts = [];
//   @override
//   void initState(){
//     super.initState();
//     askpermissions();
//   }
//   Future<void> askpermissions() async{
//   PermissionStatus permissionStatus= await getContactsPermissions();
//   if(permissionStatus==PermissionStatus.granted){
//     getAllContacts();
//   }else{
//     handleInvalidPermissions(permissionStatus);
//   }
//   }
//   handleInvalidPermissions(PermissionStatus permissionStatus){
//     if(permissionStatus==PermissionStatus.denied){
//       dialogueBox(context, "Access to the Contacts denied by the user");
//     }else{
//       dialogueBox(context, "May contact does exist in this device");
//     }
//   }
//
//   Future<PermissionStatus>getContactsPermissions() async{
// PermissionStatus permission = await Permission.contacts.status;
// if(permission!=PermissionStatus.granted && permission!=PermissionStatus.permanentlyDenied){
//   PermissionStatus permissionStatus = await Permission.contacts.request();
//   return permissionStatus;
// }else{
//    return permission;
// }
//   }
//   getAllContacts() async{
//    List<Contact> _contacts=await ContactsService.getContacts();
//    setState(() {
//      contacts = _contacts;
//    });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  contacts.length==0
//           ?Center(child: CircularProgressIndicator(),
//       ):
//       ListView.builder(
//         itemCount: contacts.length,
//           itemBuilder: (BuildContext context,int index){
//           Contact contact = contacts[index];
//            return ListTile(
//               title: Text(contact.displayName!),
//             subtitle:Text(contact.phones!.elementAt(0)
//             .value!) ,
//              leading: contact.avatar!=null && contact.avatar!.length>0?
//              CircleAvatar(
//                backgroundImage: MemoryImage(
//                  contact.avatar!
//                ),
//              ):  CircleAvatar(
//               child: Text(contact.initials()),
//              ),
//            );
//           }
//       )
//     );
//   }
// }
//This is the Original code
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:women_safety_tracking_system/db/db_services.dart';
// import 'package:women_safety_tracking_system/model/contactsm.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({super.key});
//
//   @override
//   State<ContactsPage> createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> contacts = [];
//   List<Contact> contactsFitered = [];
//   DatabaseHelper _databaseHelper = DatabaseHelper();
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = true;
//
//
//   @override
//   void initState() {
//     super.initState();
//     askpermissions();
//   }
//   String flatterPhoneNumber(String phoneStr){
//     return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m){
//       return m[0] =="+"?"+":"";
//     });
//   }
//
//
//   filterContacts(){
//     List<Contact> _contacts = [];
//     _contacts.addAll(contacts);
//     if(searchController.text.isNotEmpty){
//       _contacts.retainWhere((element){
//         String searchTerm = searchController.text.toLowerCase();
//         String searchTermFlattren = flatterPhoneNumber(searchTerm);
//         String contactName=element.displayName?.toLowerCase()??'';
//         bool nameMatch=contactName.contains(searchTerm);
//         contactName.contains(searchTerm);
//         if(nameMatch==true){
//
//           return true;
//         }
//         if(searchTermFlattren.isEmpty){
//           return false;
//         }
//         try {
//           var phone = element.phones!.firstWhere((p) {
//             String phnFlattered = flatterPhoneNumber(p.value!);
//             return phnFlattered.contains(searchTermFlattren);
//           });
//           return phone.value != null;
//         }catch(e){
//           return false;
//         }
//       });
//     }
//     setState(() {
//       contactsFitered= _contacts;
//     });
//   }
//
//   Future<void> askpermissions() async {
//     PermissionStatus permissionStatus = await getContactsPermissions();
//     if (permissionStatus == PermissionStatus.granted) {
//       getAllContacts();
//       searchController.addListener(() {
//       filterContacts();
//       });
//     } else {
//       handleInvalidPermissions(permissionStatus);
//     }
//   }
//
//   handleInvalidPermissions(PermissionStatus permissionStatus) {
//     setState(() {
//       isLoading = false;
//     });
//     if (permissionStatus == PermissionStatus.denied) {
//       dialogueBox(context, "Access to the Contacts denied by the user");
//     } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
//       dialogueBox(context, "Contact permission permanently denied. Please enable it from settings");
//     } else {
//       dialogueBox(context, "Unable to access contacts");
//     }
//   }
//
//   Future<PermissionStatus> getContactsPermissions() async {
//     PermissionStatus permission = await Permission.contacts.status;
//     if (permission != PermissionStatus.granted &&
//         permission != PermissionStatus.permanentlyDenied) {
//       PermissionStatus permissionStatus = await Permission.contacts.request();
//       return permissionStatus;
//     } else {
//       return permission;
//     }
//   }
//
//   getAllContacts() async {
//     try {
//       List<Contact> _contacts = await ContactsService.getContacts(withThumbnails: false);
//       setState(() {
//         contacts = _contacts;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       dialogueBox(context, "Error loading contacts: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isSearching=searchController.text.isNotEmpty;
//     bool listItemExit=(contactsFitered.length>0 || contacts.length>0);
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Contacts'),
//       // ),
//       body: isLoading
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: contacts.isEmpty
//             ? Center(
//                     child: Text('No contacts found'),
//                   )
//             : SafeArea(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       autofocus: true,
//                       controller: searchController,
//                       decoration: InputDecoration(
//                         labelText: "Search Contacts",
//                         prefixIcon: Icon(Icons.search)
//                       ),
//                     ),
//                   ),
//                   listItemExit==true?
//                   Expanded(
//                     child: ListView.builder(
//                     itemCount: isSearching==true?contactsFitered.length: contacts.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       Contact contact =  isSearching==true?contactsFitered[index]:contacts[index];
//
//                       // Handle null display name
//                       String displayName = contact.displayName ?? 'Unknown';
//
//                       // Handle null or empty phones
//                       String phoneNumber = 'No phone number';
//                       if (contact.phones != null && contact.phones!.isNotEmpty) {
//                         phoneNumber = contact.phones!.elementAt(0).value ?? 'No phone number';
//                       }
//
//                       return ListTile(
//                         title: Text(displayName),
//                         subtitle: Text(phoneNumber),
//                         leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
//                             ? CircleAvatar(
//                           backgroundImage: MemoryImage(contact.avatar!),
//                         )
//                             : CircleAvatar(
//                           child: Text(contact.initials()),
//                         ),
//                         onTap: (){
//                           if(contact.phones!.length>0){
//                               final String phoneNum=contact.phones!.elementAt(0).value!;
//                               final String name = contact.displayName!;
//                               _addContact(TContact(phoneNum, name));
//                           }else{
//                             Fluttertoast.showToast(msg: "Oops!! Phone number of this contact does'nt exist");
//
//                           }
//                         },
//                       );
//                     }),
//                   ):Container(
//                     child: Text("Searching"),
//                   )
//                 ],
//               ),
//             ),
//           ),
//     );
//   }
//   void _addContact(TContact newContact) async{
//    int result = await _databaseHelper.insertContact(newContact);
//    if(result!=0){
//      Fluttertoast.showToast(msg: "Contact added Successfully");
//    }else{
//      Fluttertoast.showToast(msg: "Failed Add Contact");
//    }
//    Navigator.of(context).pop(true);
//   }
//
// }

//This is the edited code with UI changed
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_tracking_system/db/db_services.dart';
import 'package:women_safety_tracking_system/model/contactsm.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFitered = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    askpermissions();
  }

  String flatterPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlattren = flatterPhoneNumber(searchTerm);
        String contactName = element.displayName?.toLowerCase() ?? '';
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch == true) {
          return true;
        }
        if (searchTermFlattren.isEmpty) {
          return false;
        }
        try {
          var phone = element.phones!.firstWhere((p) {
            String phnFlattered = flatterPhoneNumber(p.value!);
            return phnFlattered.contains(searchTermFlattren);
          });
          return phone.value != null;
        } catch (e) {
          return false;
        }
      });
    }
    setState(() {
      contactsFitered = _contacts;
    });
  }

  Future<void> askpermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    setState(() {
      isLoading = false;
    });
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "Access to the Contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogueBox(
          context, "Contact permission permanently denied. Please enable it from settings");
    } else {
      dialogueBox(context, "Unable to access contacts");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    try {
      List<Contact> _contacts =
      await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        contacts = _contacts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      dialogueBox(context, "Error loading contacts: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFitered.length > 0 || contacts.length > 0);

    return Scaffold(
      body: Stack(
        children: [
          // 🌸 Background Image
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

          // 🌸 Main content
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: contacts.isEmpty
                ? const Center(
              child: Text('No contacts found'),
            )
                : SafeArea(
              child: Column(
                children: [
                  // 🔍 Search Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: "Search Contacts",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  // 📜 Contacts List (no card view)
                  listItemExit
                      ? Expanded(
                    child: ListView.builder(
                        itemCount: isSearching
                            ? contactsFitered.length
                            : contacts.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          Contact contact = isSearching
                              ? contactsFitered[index]
                              : contacts[index];

                          String displayName =
                              contact.displayName ?? 'Unknown';
                          String phoneNumber = 'No phone number';
                          if (contact.phones != null &&
                              contact.phones!.isNotEmpty) {
                            phoneNumber = contact.phones!
                                .elementAt(0)
                                .value ??
                                'No phone number';
                          }

                          return ListTile(
                            title: Text(
                              displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              phoneNumber,
                              style: const TextStyle(
                                  color: Colors.black54),
                            ),
                            leading: (contact.avatar != null &&
                                contact.avatar!.isNotEmpty)
                                ? CircleAvatar(
                              backgroundImage:
                              MemoryImage(
                                  contact.avatar!),
                            )
                                : CircleAvatar(
                              backgroundColor:
                              Colors.pink[100],
                              child: Text(
                                  contact.initials()),
                            ),
                            onTap: () {
                              if (contact.phones!.isNotEmpty) {
                                final String phoneNum =
                                contact.phones!
                                    .elementAt(0)
                                    .value!;
                                final String name =
                                contact.displayName!;
                                _addContact(
                                    TContact(phoneNum, name));
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                    "Oops!! Phone number of this contact doesn't exist");
                              }
                            },
                          );
                        }),
                  )
                      : const Text("Searching..."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addContact(TContact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact added Successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to Add Contact");
    }
    Navigator.of(context).pop(true);
  }
}
