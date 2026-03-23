import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/components/SecondaryButton.dart';
import 'package:women_safety_tracking_system/components/custom_textfield.dart';
import 'package:women_safety_tracking_system/child/child_login_screen.dart';
import 'package:women_safety_tracking_system/model/user_model.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class RegisterParentScreen extends StatefulWidget{
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  //const RegisterChildScreen({Key? key}) : super(key:key);
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _onSubmit() async {
    _formKey.currentState!.save();

    // Validate matching passwords
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(context, 'Password and retype password should be the same');
      return;
    }

    try {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _formData['gemail'].toString(),
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
            type: "Parent",
          );

          // Convert to JSON and save to Firestore
          final jsonData = user.toJson();
          await db.set(jsonData);

          // Close progress indicator and navigate to login
          Navigator.pop(context);
          goTo(context, LoginScreen());
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Close the loading
        dialogueBox(context, e.message ?? "Something went wrong");
      } catch (e) {
        Navigator.pop(context);
        dialogueBox(context, e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        dialogueBox(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        dialogueBox(context, 'The account already exists for that email.');
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      setState(() {
        isLoading=false;
      });
      dialogueBox(context, e.toString());

    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset:
      true,
      body: SafeArea(
      // 🌸 CHANGED: Replaced Stack with a Container background
      child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/women1.jpg'),
    fit: BoxFit.contain, // 🌸 Adjusts size without zooming too much
    alignment: Alignment.center,
    colorFilter: ColorFilter.mode(
    Colors.white.withOpacity(0.7), // 🌸 softens background
    BlendMode.lighten,
    ),
    ),
    ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Register As Parent",
                            textAlign: TextAlign.center,
                            style: TextStyle(

                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color:  Color(0xFFf67280),
                            ),
                          ),
                          Image.asset(
                            'assets/logo.png',
                            height: 140,
                            width: 140,

                          ),
                          SizedBox(height: 5),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: 'Enter your name',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.name,
                                  prefix: Icon(Icons.person),
                                  onsave: (name){
                                    _formData['name']=name ?? "";
                                  },
                                  validate: (name){
                                    if(name!.isEmpty || name.length<2){
                                      return "Enter Correct name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 17),
                                CustomTextField(
                                  hintText: 'Enter Phone number',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.phone,
                                  prefix: Icon(Icons.phone),
                                  onsave: (phone){
                                    _formData['phone']=phone ?? "";
                                  },
                                  validate: (phone){
                                    if(phone!.isEmpty || phone.length!=10){
                                      return "Enter correct Phone number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 17),
                                CustomTextField(
                                  hintText: 'Enter your email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.email),
                                  onsave: (gemail){
                                    _formData['gemail']=gemail ?? "";
                                  },
                                  validate: (gemail){
                                    if(gemail!.isEmpty || gemail.length<3 || !gemail.contains("@")){
                                      return "Enter Correct Email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 17),
                                CustomTextField(
                                  hintText: 'Enter Child email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.email),
                                  onsave: (cemail){
                                    _formData['cemail']=cemail ?? "";
                                  },
                                  validate: (cemail){
                                    if(cemail!.isEmpty || cemail.length<3 || !cemail.contains("@")){
                                      return "Enter Correct Email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 17),
                                CustomTextField(
                                  hintText: 'Enter Password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.lock),
                                  onsave: (password){
                                    _formData['password']=password ?? "";
                                  },
                                  validate: (password){
                                    if(password!.isEmpty || password.length<7){
                                      return "Enter Correct Password";
                                    }
                                    return null;
                                  },
                                  suffix: IconButton(onPressed:(){
                                    setState(() {
                                      isPasswordShown = !isPasswordShown;
                                    });
                                  },icon: isPasswordShown?Icon(Icons.visibility_off): Icon(Icons.visibility),),
                                ),
                                SizedBox(height: 17),
                                CustomTextField(
                                  hintText: 'Retype Password',
                                  isPassword: isRetypePasswordShown,
                                  prefix: Icon(Icons.lock),
                                  onsave: (password){
                                    _formData['rpassword']=password ?? "";
                                  },
                                  validate: (password){
                                    if(password!.isEmpty || password.length<7){
                                      return "Enter Correct Password";
                                    }
                                    return null;
                                  },
                                  suffix: IconButton(onPressed:(){
                                    setState(() {
                                      isRetypePasswordShown = !isRetypePasswordShown;
                                    });
                                  },icon: isRetypePasswordShown?Icon(Icons.visibility_off): Icon(Icons.visibility),),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 17),
                          PrimaryButton(title: "Register", onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _onSubmit();
                            }
                          }),
                          SecondaryButton(title: "Back to Login", onPressed: () {
                            goTo(context, LoginScreen());
                          }),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}



