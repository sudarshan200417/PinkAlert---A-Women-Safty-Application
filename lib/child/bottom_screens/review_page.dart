// import 'package:flutter/material.dart';
//
// class ReviewPage extends StatelessWidget {
//   const ReviewPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Rating Page')),
//     );
//   }
// }
// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
// import 'package:women_safety_tracking_system/components/custom_textfield.dart';
// import 'package:women_safety_tracking_system/utils/constants.dart';
//
// class ReviewPage extends StatefulWidget {
//   @override
//   State<ReviewPage> createState() => _ReviewPageState();
// }
//
// class _ReviewPageState extends State<ReviewPage> {
//   TextEditingController locationC = TextEditingController();
//   TextEditingController viewsC = TextEditingController();
//   bool isSaving = false;
//   double? ratings;
//
//   showAlert(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (_) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.all(2.0),
//             title: Text("Review your place"),
//             content: Form(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CustomTextField(
//                         hintText: 'enter location',
//                         controller: locationC,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CustomTextField(
//                         controller: viewsC,
//                         hintText: 'Comment here',
//                         maxLines: 3,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     RatingBar.builder(
//                       initialRating: 1,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       itemCount: 5,
//                       unratedColor: Colors.grey.shade300,
//                       itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       itemBuilder: (context, _) =>
//                       const Icon(Icons.star, color: kColorDarkRed),
//                       onRatingUpdate: (rating) {
//                         setState(() {
//                           ratings = rating;
//                         });
//                       },
//                     ),
//                   ],
//                 )),
//             actions: [
//               PrimaryButton(
//                   title: "SAVE",
//                   onPressed: () {
//                     saveReview();
//                     Navigator.pop(context);
//                   }),
//               TextButton(
//                   child: Text("Cancel"),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//             ],
//           );
//         });
//   }
//
//   saveReview() async {
//     setState(() {
//       isSaving = true;
//     });
//     await FirebaseFirestore.instance.collection('reviews').add({
//       'location': locationC.text,
//       'views': viewsC.text,
//       "ratings": ratings
//     }).then((value) {
//       setState(() {
//         isSaving = false;
//         Fluttertoast.showToast(msg: 'review uploaded successfully');
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isSaving == true
//           ? Center(child: CircularProgressIndicator())
//           : SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Recent Review by other",
//                 style: TextStyle(fontSize: 25, color: Colors.black),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('reviews')
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   return ListView.separated(
//                     separatorBuilder: (context, index) {
//                       return Divider();
//                     },
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final data = snapshot.data!.docs[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Card(
//                           // color: Colors.pink[50],
//                          color: Color(0xFFFFB5C5),
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Location : ${data['location']}",
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.black),
//                                 ),
//                                 Text(
//                                   "Comments : ${data['views']}",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.black),
//                                 ),
//                                 RatingBar.builder(
//                                   initialRating: data['ratings'],
//                                   minRating: 1,
//                                   direction: Axis.horizontal,
//                                   itemCount: 5,
//                                   ignoreGestures: true,
//                                   unratedColor: Colors.grey.shade300,
//                                   itemPadding: const EdgeInsets.symmetric(
//                                       horizontal: 4.0),
//                                   itemBuilder: (context, _) => const Icon(
//                                       Icons.star,
//                                       color: kColorDarkRed),
//                                   onRatingUpdate: (rating) {
//                                     setState(() {
//                                       ratings = rating;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xFFF67280),
//         onPressed: () {
//           showAlert(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_tracking_system/components/PrimaryButton.dart';
import 'package:women_safety_tracking_system/components/custom_textfield.dart';
import 'package:women_safety_tracking_system/utils/constants.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController locationC = TextEditingController();
  TextEditingController viewsC = TextEditingController();
  bool isSaving = false;
  double? ratings;

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(2.0),
          title: const Text("Review your place"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter location',
                    controller: locationC,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: viewsC,
                    hintText: 'Comment here',
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 15),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  unratedColor: Colors.grey.shade300,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: kColorDarkRed),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratings = rating;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            PrimaryButton(
              title: "SAVE",
              onPressed: () {
                saveReview();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  saveReview() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('reviews').add({
      'location': locationC.text,
      'views': viewsC.text,
      "ratings": ratings
    }).then((value) {
      setState(() {
        isSaving = false;
        Fluttertoast.showToast(msg: 'Review uploaded successfully');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSaving
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        // 🌸 ADDED: Background container for the repeating pattern
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Bg_image.png'),
              repeat: ImageRepeat.repeat,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.lighten,
              ),
            ),
          ),
          // 🌸 Your actual page content inside child:
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add Your Reviews",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('reviews')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                      const Divider(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            //color: Color(0xFFF3D1DD),
                            elevation: 4,
                            shadowColor:
                            Colors.pink.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location: ${data['location']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Comments: ${data['views']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  RatingBar.builder(
                                    initialRating:
                                    data['ratings'].toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey.shade300,
                                    itemPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) =>
                                    const Icon(Icons.star,
                                        color: kColorDarkRed),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratings = rating;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF67280),
        onPressed: () {
          showAlert(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
