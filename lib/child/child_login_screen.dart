// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
// import 'package:women_safety_tracking_system/components/custom_textfield.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.top -
//                     MediaQuery.of(context).padding.bottom -
//                     16,
//               ),
//               child: IntrinsicHeight(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "Login",
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
//                     Column(
//                       children: [
//                         CustomTextField(
//                           hintText: 'Username',
//                           prefix: Icon(Icons.person),
//                         ),
//                         SizedBox(height: 35),
//                         CustomTextField(
//                           hintText: 'Password',
//                           prefix: Icon(Icons.person),
//                         ),
//                       ],
//                     ),
//                     PrimaryButton(title: "Login", onPressed: () {}),
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Forgot Password? ",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             SecondaryButton(title: 'Click here', onPressed: () {}),
//                           ],
//                         ),
//                         SizedBox(height: 6),
//                         SecondaryButton(title: "Register new user", onPressed: () {}),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/auth/Forgot_Password_screen.dart';
import 'package:women_safety_tracking_system/child/bottom_screens/child_home_page.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
import 'package:women_safety_tracking_system/components/custom_textfield.dart';
import 'package:women_safety_tracking_system/child/register_child.dart';
import 'package:women_safety_tracking_system/db/Shared_preferences.dart';
import 'package:women_safety_tracking_system/parent/parent_home_screen.dart';
import 'package:women_safety_tracking_system/parent/parent_register_screen.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //const LoginScreen({Key? key}) : super(key: key);
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async{
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _formData['email'].toString(),
          password: _formData['password'].toString(),
      );
      if(userCredential.user != null){
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance.collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value){
          String email = userCredential.user!.email!; // ✅ ADD
              if(value['type']=='Parent'){
                print(value['type']);
                MySharedPreferences.saveUserType('Parent');
                MySharedPreferences.saveUserEmail(email); // ✅ ADD
                goTo(context,ParentHomeScreen());
              }else{
                print(value['type']);
                MySharedPreferences.saveUserType('child');
                MySharedPreferences.saveUserEmail(email); // ✅ ADD
                goTo(context, HomeScreen());
              }
        });

      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = true;
      });
      if (e.code == 'user-not-found') {
        dialogueBox(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogueBox(context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
    // print(_formData['email']);
    // print(_formData['password']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/women1.jpg'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.4),
              BlendMode.lighten,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.4),
                Color(0xFFFFF5F7).withOpacity(0.5),
                Colors.white.withOpacity(0.4),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  isLoading
                      ? progressIndicator(context)
                      : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: kColorLightRed1),
                              ),
                              Image.asset(
                                'assets/logo.png',
                                height: 140,
                                width: 140,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'Enter your email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (email) {
                                    _formData['email'] = email ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 ||
                                        !email.contains("@")) {
                                      return 'Enter correct email';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'Enter your password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'Enter correct password';
                                    }
                                    return null;
                                  },
                                  onsave: (password) {
                                    _formData['password'] = password ?? "";
                                  },
                                  suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                ),
                                PrimaryButton(
                                    title: 'Login',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(fontSize: 18),
                              ),
                              SecondaryButton(
                                  title: 'click here', onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                                );
                              }),
                            ],
                          ),
                        ),
                        SecondaryButton(
                            title: 'Register as child',
                            onPressed: () {
                              goTo(context, RegisterChildScreen());
                            }),
                        SecondaryButton(
                            title: 'Register as parent',
                            onPressed: () {
                              goTo(context, RegisterParentScreen());
                            }),
                      ],
                    ),
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/women1.jpg'),
//           fit: BoxFit.contain,
//           colorFilter: ColorFilter.mode(
//             Colors.white.withOpacity(0.4),
//             BlendMode.lighten,
//           ),
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.white.withOpacity(0.4),
//               Color(0xFFFFF5F7).withOpacity(0.5),
//               Colors.white.withOpacity(0.4),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: MediaQuery.of(context).size.height -
//                       MediaQuery.of(context).padding.top -
//                       MediaQuery.of(context).padding.bottom -
//                       16,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "Welcome Back..!!",
//                         style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFf67280),
//                         ),
//                       ),
//                       Image.asset(
//                         'assets/logo.png',
//                         height: 100,
//                         width: 100,
//                       ),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               hintText: 'Email',
//                               textInputAction: TextInputAction.next,
//                               keyboardtype: TextInputType.emailAddress,
//                               prefix: Icon(Icons.person),
//                               onsave: (email){
//                                 _formData['email']=email ?? "";
//                               },
//                               validate: (email){
//                                 if(email!.isEmpty || email.length>3 || !email.contains("@")){
//                                     return "Enter Correct Email";
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 17),
//                             CustomTextField(
//                               hintText: 'Password',
//                               isPassword: isPasswordShown,
//                               prefix: Icon(Icons.lock),
//                               onsave: (password){
//                                 _formData['password']=password ?? "";
//                               },
//                               validate: (password){
//                                 if(password!.isEmpty || password.length>7){
//                                   return "Enter Correct Password";
//                                 }
//                                 return null;
//                               },
//                               suffix: IconButton(onPressed:(){
//                                 setState(() {
//                                   isPasswordShown = !isPasswordShown;
//                                 });
//                               },icon: isPasswordShown?Icon(Icons.visibility_off): Icon(Icons.visibility),),
//                             ),
//                           ],
//                         ),
//                       ),
//                       PrimaryButton(title: "Login",
//                           onPressed: () {
//                         if(_formKey.currentState!.validate()){
//                           _onSubmit();
//                         }
//                       }),
//                       Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Forgot Password?",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               SecondaryButton(title: 'Click here', onPressed: () {}),
//                             ],
//                           ),
//                           SizedBox(height: 3),
//                           SecondaryButton(title: "Register child user", onPressed: () {
//                             goTo(context, RegisterChildScreen());
//                           }),
//                           SecondaryButton(title: "Register parent user", onPressed: () {
//                             goTo(context, RegisterParentScreen());
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );