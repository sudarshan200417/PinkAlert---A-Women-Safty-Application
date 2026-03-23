// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
// import 'package:women_safety_tracking_system/components/custom_textfield.dart';
// import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// class RegisterChildScreen extends StatefulWidget{
//   @override
//   State<RegisterChildScreen> createState() => _RegisterChildScreenState();
// }
//
// class _RegisterChildScreenState extends State<RegisterChildScreen> {
//    //const RegisterChildScreen({Key? key}) : super(key:key);
//   bool isPasswordShown = true;
//
//   final _formKey = GlobalKey<FormState>();
//
//   final _formData = Map<String, Object>();
//
//   _onSubmit(){
//     _formKey.currentState!.save();
//     if(_formData['password']!=_formData['rpassword']){
//       dialogueBox(context, 'Password and retype password should be same');
//     }else{
//       progressIndicator(context);
//       try{
//         FirebaseAuth auth = FirebaseAuth.instance;
//         auth.createUserWithEmailAndPassword(email: _formData["email"].toString(), password:_formData["password"].toString()).whenComplete(() => goTo(context,LoginScreen()));
//       }
//       on FirebaseAuthException catch (e){
//         dialogueBox(context, e.toString());
//       }
//       catch(e){
//         dialogueBox(context, e.toString());
//       }
//     }
//     print(_formData['email']);
//     print(_formData['password']);
//   }
//
//    @override
//   Widget build(BuildContext context){
//      return Scaffold(
//        resizeToAvoidBottomInset:
//        true,
//        body: SafeArea(
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 10),
//            child: SingleChildScrollView(
//              child: Column(
//                children: [
//                  Container(
//                   // height: MediaQuery.of(context).size.height * 0.95,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Text(
//                          "Register As Child",
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//
//                            fontSize: 40,
//                            fontWeight: FontWeight.bold,
//                            color:  Color(0xFFf67280),
//                          ),
//                        ),
//                        Image.asset(
//                            'assets/logo.png',
//                          height: 100,
//                          width: 100,
//
//                        ),
//                        SizedBox(height: 5),
//                        Form(
//                          key: _formKey,
//                          child: Column(
//                            children: [
//                              CustomTextField(
//                                hintText: 'Enter your name',
//                                textInputAction: TextInputAction.next,
//                                keyboardtype: TextInputType.name,
//                                prefix: Icon(Icons.person),
//                                onsave: (name){
//                                  _formData['name']=name ?? "";
//                                // },
//                                // validate: (name){
//                                  if(name!.isEmpty || name.length>=2){
//                                    return "Enter Correct name";
//                                  }
//                                  return null;
//                                },
//                              ),
//                              SizedBox(height: 17),
//                              CustomTextField(
//                                hintText: 'Enter Phone number',
//                                textInputAction: TextInputAction.next,
//                                keyboardtype: TextInputType.phone,
//                                prefix: Icon(Icons.phone),
//                                onsave: (phone){
//                                  _formData['phone']=phone ?? "";
//                                },
//                                validate: (phone){
//                                  if(phone!.isEmpty || phone.length>=10){
//                                    return "Enter correct Phone number";
//                                  }
//                                  return null;
//                                },
//                              ),
//                              SizedBox(height: 17),
//                              CustomTextField(
//                                hintText: 'Enter your email',
//                                textInputAction: TextInputAction.next,
//                                keyboardtype: TextInputType.emailAddress,
//                                prefix: Icon(Icons.email),
//                                onsave: (email){
//                                  _formData['email']=email ?? "";
//                                },
//                                validate: (email){
//                                  if(email!.isEmpty || email.length>3 || !email.contains("@")){
//                                    return "Enter Correct Email";
//                                  }
//                                  return null;
//                                },
//                              ),
//                              SizedBox(height: 17),
//                              CustomTextField(
//                                hintText: 'Enter Guardian email',
//                                textInputAction: TextInputAction.next,
//                                keyboardtype: TextInputType.emailAddress,
//                                prefix: Icon(Icons.email),
//                                onsave: (gemail){
//                                  _formData['gemail']=gemail ?? "";
//                                },
//                                validate: (gemail){
//                                  if(gemail!.isEmpty || gemail.length>3 || !gemail.contains("@")){
//                                    return "Enter Correct Email";
//                                  }
//                                  return null;
//                                },
//                              ),
//                              SizedBox(height: 17),
//                              CustomTextField(
//                                hintText: 'Enter Password',
//                                isPassword: isPasswordShown,
//                                prefix: Icon(Icons.lock),
//                                onsave: (password){
//                                  _formData['password']=password ?? "";
//                                },
//                                validate: (password){
//                                  if(password!.isEmpty || password.length>7){
//                                    return "Enter Correct Password";
//                                  }
//                                  return null;
//                                },
//                                suffix: IconButton(onPressed:(){
//                                  setState(() {
//                                    isPasswordShown = !isPasswordShown;
//                                  });
//                                },icon: isPasswordShown?Icon(Icons.visibility_off): Icon(Icons.visibility),),
//                              ),
//                              SizedBox(height: 17),
//                              CustomTextField(
//                                hintText: 'Retype Password',
//                                isPassword: isPasswordShown,
//                                prefix: Icon(Icons.lock),
//                                onsave: (password){
//                                  _formData['rpassword']=password ?? "";
//                                },
//                                validate: (password){
//                                  if(password!.isEmpty || password.length>7){
//                                    return "Enter Correct Password";
//                                  }
//                                  return null;
//                                },
//                                suffix: IconButton(onPressed:(){
//                                  setState(() {
//                                    isPasswordShown = !isPasswordShown;
//                                  });
//                                },icon: isPasswordShown?Icon(Icons.visibility_off): Icon(Icons.visibility),),
//                              ),
//                            ],
//                          ),
//                        ),
//                        SizedBox(height: 17),
//                        PrimaryButton(title: "Register", onPressed: () {
//                          if(_formKey.currentState!.validate()){
//                            _onSubmit();
//                          }
//                        }),
//                        SecondaryButton(title: "login with your account", onPressed: () {
//                          goTo(context, LoginScreen());
//                        }),
//
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ),
//      );
//    }
// }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
// import 'package:women_safety_tracking_system/components/custom_textfield.dart';
// import 'package:women_safety_tracking_system/child/child_login_screen.dart';
// import 'package:women_safety_tracking_system/model/user_model.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// class RegisterChildScreen extends StatefulWidget {
//   @override
//   State<RegisterChildScreen> createState() => _RegisterChildScreenState();
// }
//
// class _RegisterChildScreenState extends State<RegisterChildScreen> {
//   bool isPasswordShown = true;
//   bool isRetypePasswordShown = true;
//   final _formKey = GlobalKey<FormState>();
//   final _formData = Map<String, Object>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> _onSubmit() async {
//     _formKey.currentState!.save();
//
//     // Validate matching passwords
//     if (_formData['password'] != _formData['rpassword']) {
//       dialogueBox(context, 'Password and retype password should be the same');
//       return;
//     }
//
//     try {
//       progressIndicator(context);
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//             email: _formData['email'].toString(),
//             password: _formData['password'].toString(),
//         );
//         if(userCredential.user!=null){
//           String uid = userCredential.user!.uid;
//
//           // Create user document in Firestore
//           DocumentReference<Map<String, dynamic>> db =
//           FirebaseFirestore.instance.collection('users').doc(uid);
//
//           // Create user model
//           final user = UserModel(
//             name: _formData['name'].toString(),
//             phone: _formData['phone'].toString(),
//             childEmail: _formData['email'].toString(),
//             guardianEmail: _formData['gemail'].toString(),
//             id: uid,
//           );
//
//           // Convert to JSON and save to Firestore
//           final jsonData = user.toJson();
//           await db.set(jsonData);
//
//           // Close progress indicator and navigate to login
//           Navigator.pop(context);
//           goTo(context, LoginScreen());
//
//         } on FirebaseAuthException catch (e) {
//         Navigator.pop(context); // Close the loading
//         dialogueBox(context, e.message ?? "Something went wrong");
//       } catch (e) {
//         Navigator.pop(context);
//         dialogueBox(context, e.toString());
//       }
//         }
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           print('The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           print('The account already exists for that email.');
//         }
//       } catch (e) {
//         print(e);
//       }
//
//       // Create user with Firebase Auth
//       // UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       //   email: _formData['email'].toString(),
//       //   password: _formData['password'].toString(),
//       // );
//
//       // Get the user ID
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "Register As Child",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFFf67280),
//                       ),
//                     ),
//                     Image.asset(
//                       'assets/logo.png',
//                       height: 100,
//                       width: 100,
//                     ),
//                     SizedBox(height: 5),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           /// --- Name Field ---
//                           CustomTextField(
//                             hintText: 'Enter your name',
//                             textInputAction: TextInputAction.next,
//                             keyboardtype: TextInputType.name,
//                             prefix: Icon(Icons.person),
//                             onsave: (name) {
//                               _formData['name'] = name ?? "";
//                             },
//                             validate: (name) {
//                               if (name == null || name.isEmpty) {
//                                 return "Enter your name";
//                               } else if (name.length < 2) {
//                                 return "Enter correct name";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 17),
//
//                           /// --- Phone Field ---
//                           CustomTextField(
//                             hintText: 'Enter Phone number',
//                             textInputAction: TextInputAction.next,
//                             keyboardtype: TextInputType.phone,
//                             prefix: Icon(Icons.phone),
//                             onsave: (phone) {
//                               _formData['phone'] = phone ?? "";
//                             },
//                             validate: (phone) {
//                               if (phone == null || phone.isEmpty) {
//                                 return "Enter phone number";
//                               } else if (!RegExp(r'^[0-9]{10}$')
//                                   .hasMatch(phone)) {
//                                 return "Enter correct Phone number";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 17),
//
//                           /// --- Child Email ---
//                           CustomTextField(
//                             hintText: 'Enter your email',
//                             textInputAction: TextInputAction.next,
//                             keyboardtype: TextInputType.emailAddress,
//                             prefix: Icon(Icons.email),
//                             onsave: (email) {
//                               _formData['email'] = email ?? "";
//                             },
//                             validate: (email) {
//                               if (email == null || email.isEmpty) {
//                                 return "Enter your email";
//                               } else if (!RegExp(
//                                   r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
//                                   .hasMatch(email)) {
//                                 return "Enter correct email";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 17),
//
//                           /// --- Guardian Email ---
//                           CustomTextField(
//                             hintText: 'Enter Guardian email',
//                             textInputAction: TextInputAction.next,
//                             keyboardtype: TextInputType.emailAddress,
//                             prefix: Icon(Icons.email),
//                             onsave: (gemail) {
//                               _formData['gemail'] = gemail ?? "";
//                             },
//                             validate: (gemail) {
//                               if (gemail == null || gemail.isEmpty) {
//                                 return "Enter guardian email";
//                               } else if (!RegExp(
//                                   r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
//                                   .hasMatch(gemail)) {
//                                 return "Enter correct email";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 17),
//
//                           /// --- Password Field ---
//                           CustomTextField(
//                             hintText: 'Enter Password',
//                             isPassword: isPasswordShown,
//                             prefix: Icon(Icons.lock),
//                             onsave: (password) {
//                               _formData['password'] = password ?? "";
//                             },
//                             validate: (password) {
//                               if (password == null || password.isEmpty) {
//                                 return "Enter password";
//                               } else if (password.length < 7) {
//                                 return "Password must be at least 7 characters";
//                               }
//                               return null;
//                             },
//                             suffix: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isPasswordShown = !isPasswordShown;
//                                 });
//                               },
//                               icon: isPasswordShown
//                                   ? Icon(Icons.visibility_off)
//                                   : Icon(Icons.visibility),
//                             ),
//                           ),
//                           SizedBox(height: 17),
//
//                           /// --- Retype Password Field ---
//                           CustomTextField(
//                             hintText: 'Retype Password',
//                             isPassword: isPasswordShown ,
//                             prefix: Icon(Icons.lock),
//                             onsave: (password) {
//                               _formData['rpassword'] = password ?? "";
//                             },
//                             validate: (password) {
//                               if (password == null || password.isEmpty) {
//                                 return "Retype your password";
//                               } else if (password.length < 7) {
//                                 return "Password must be at least 7 characters";
//                               }
//                               return null;
//                             },
//                             suffix: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isRetypePasswordShown  = !isRetypePasswordShown ;
//                                 });
//                               },
//                               icon: isRetypePasswordShown
//                                   ? Icon(Icons.visibility_off)
//                                   : Icon(Icons.visibility),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 17),
//
//                     /// --- Register Button ---
//                     PrimaryButton(
//                       title: "Register",
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _onSubmit();
//                         }
//                       },
//                     ),
//
//                     /// --- Secondary Login Button ---
//                     SecondaryButton(
//                       title: "Login with your account",
//                       onPressed: () {
//                         goTo(context, LoginScreen());
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
import 'package:women_safety_tracking_system/components/custom_textfield.dart';
import 'package:women_safety_tracking_system/child/child_login_screen.dart';
import 'package:women_safety_tracking_system/model/user_model.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _onSubmit() async {
    _formKey.currentState!.save();

    // Validate matching passwords
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(context, 'Password and retype password should be the same');
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
// login credential
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _formData['cemail'].toString(),
        password: _formData['password'].toString(),
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        // Create user document in Firestore
        DocumentReference<Map<String, dynamic>> db =
        FirebaseFirestore.instance.collection('users').doc(uid);

        // Create user model
        final user = UserModel(
          name: _formData['name'].toString(),
          phone: _formData['phone'].toString(),
          childEmail: _formData['cemail'].toString(),
          guardianEmail: _formData['gemail'].toString(),
          id: uid,
          type: "child",
        );

        // Convert to JSON and save to Firestore
        final jsonData = user.toJson();
        await db.set(jsonData);

        // Navigate to login
        setState(() {
          isLoading = false;
        });
        goTo(context, LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'weak-password') {
        dialogueBox(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        dialogueBox(context, 'The account already exists for that email.');
      } else {
        dialogueBox(context, e.message ?? "Something went wrong");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      dialogueBox(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        //  Replaced Stack with a Container background
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/women1.jpg'),
              fit: BoxFit.contain,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7),
                BlendMode.lighten,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isLoading
                ? progressIndicator(context)
                : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 20),

                      // 🌸 Title
                      Text(
                        "Register As Child",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFf67280),
                        ),
                      ),


                      Image.asset(
                        'assets/logo.png',
                        height: 140,
                        width: 140,
                      ),
                      const SizedBox(height: 5),

                      // 🌸 Form Fields
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Enter your name',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.name,
                              prefix: const Icon(Icons.person),
                              onsave: (name) {
                                _formData['name'] = name ?? "";
                              },
                              validate: (name) {
                                if (name == null || name.isEmpty) {
                                  return "Enter your name";
                                } else if (name.length < 2) {
                                  return "Enter correct name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 17),

                            CustomTextField(
                              hintText: 'Enter Phone number',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.phone,
                              prefix: const Icon(Icons.phone),
                              onsave: (phone) {
                                _formData['phone'] = phone ?? "";
                              },
                              validate: (phone) {
                                if (phone == null || phone.isEmpty) {
                                  return "Enter phone number";
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(phone)) {
                                  return "Enter correct Phone number";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 17),

                            CustomTextField(
                              hintText: 'Enter your email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: const Icon(Icons.email),
                              onsave: (email) {
                                _formData['cemail'] = email ?? "";
                              },
                              validate: (email) {
                                if (email == null || email.isEmpty) {
                                  return "Enter your email";
                                } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                    .hasMatch(email)) {
                                  return "Enter correct email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 17),

                            CustomTextField(
                              hintText: 'Enter Guardian email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: const Icon(Icons.email),
                              onsave: (gemail) {
                                _formData['gemail'] = gemail ?? "";
                              },
                              validate: (gemail) {
                                if (gemail == null || gemail.isEmpty) {
                                  return "Enter guardian email";
                                } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                    .hasMatch(gemail)) {
                                  return "Enter correct email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 17),

                            CustomTextField(
                              hintText: 'Enter Password',
                              isPassword: isPasswordShown,
                              prefix: const Icon(Icons.lock),
                              onsave: (password) {
                                _formData['password'] = password ?? "";
                              },
                              validate: (password) {
                                if (password == null ||
                                    password.isEmpty) {
                                  return "Enter password";
                                } else if (password.length < 7) {
                                  return "Password must be at least 7 characters";
                                }
                                return null;
                              },
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordShown = !isPasswordShown;
                                  });
                                },
                                icon: isPasswordShown
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                            const SizedBox(height: 17),

                            CustomTextField(
                              hintText: 'Retype Password',
                              isPassword: isRetypePasswordShown,
                              prefix: const Icon(Icons.lock),
                              onsave: (password) {
                                _formData['rpassword'] = password ?? "";
                              },
                              validate: (password) {
                                if (password == null ||
                                    password.isEmpty) {
                                  return "Retype your password";
                                } else if (password.length < 7) {
                                  return "Password must be at least 7 characters";
                                }
                                return null;
                              },
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isRetypePasswordShown =
                                    !isRetypePasswordShown;
                                  });
                                },
                                icon: isRetypePasswordShown
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),

                      PrimaryButton(
                        title: "Register",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onSubmit();
                          }
                        },
                      ),
                      SecondaryButton(
                        title: "Back to Login",
                        onPressed: () {
                          goTo(context, LoginScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
