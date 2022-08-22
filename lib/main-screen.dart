import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_app/size-helper.dart';
import 'package:dietary_app/utilities/firebase-getters.dart';
import 'package:dietary_app/widgets/accesdata.dart';
import 'package:dietary_app/widgets/cards-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  searching search=searching();

  bool isselected=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Opacity(
                opacity: 0.90,
                child: Container(
                  height: displayHeight(context) - 76,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/homescreenbg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      TimeDate(),
                      style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 150),
                              child: Text(
                                "Hello,",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 100.0),
                              child: Text(
                                getDisplayName(),
                                style: TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                         Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://static-media-prod-cdn.itsre-sumo.mozilla.net/static/default-FFA-avatar.2f8c2a0592bda1c5.png",
                            ),
                            radius: 30,

                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Low Calory meals",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       height: 280,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //         itemCount: 2,
                  //         itemBuilder: (context, index) => Container(
                  //           padding: const EdgeInsets.symmetric(vertical: 8),
                  //           margin: const EdgeInsets.symmetric(
                  //               horizontal: 8, vertical: 5),
                  //           decoration: const BoxDecoration(
                  //               color: Color(0x80FFFFFF),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(40))),
                  //           height: 270,
                  //           width: 190,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //
                  //               const CircleAvatar(
                  //                   radius: 70,
                  //                   backgroundImage: AssetImage(
                  //                     "assets/images/food.jpg",
                  //                   )),
                  //               const Text(
                  //                 "Foodname",
                  //                 style: TextStyle(
                  //                     fontSize: 30,
                  //                     fontStyle: FontStyle.italic),
                  //               ),
                  //               const Text(
                  //                 "Calories",
                  //                 style: TextStyle(
                  //                     color: Colors.red,
                  //                     fontSize: 25,
                  //                     fontStyle: FontStyle.italic),
                  //               ),
                  //               Container(
                  //                 margin: const EdgeInsets.only(left: 120),
                  //                 child: const CircleAvatar(
                  //                   radius: 20,
                  //                   backgroundColor: Colors.red,
                  //                   child: Icon(
                  //                     Icons.favorite_border_outlined,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
            StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection('Fruits')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView(
                      shrinkWrap: true,
                        children: documents
                            .map(
                              (doc) => Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 10, bottom: 10),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 280,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 55,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: const BoxDecoration(
                                                color: Color(0x80FFFFFF),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 270,
                                            width: 190,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                const CircleAvatar(
                                                    radius: 70,
                                                    backgroundImage: AssetImage(
                                                      "assets/images/food.jpg",
                                                    )),
                                                Text(
                                                  doc['name'][index].toString(),
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                Text(
                                                  doc['values'][index].toString(),
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 120),
                                                  child:  CircleAvatar(
                                                    radius: 20,

                                                    backgroundColor: isselected==false?Colors.green:Colors.red,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          isselected=!isselected;
                                                        });
                                                        FirebaseAuth _auth=FirebaseAuth.instance;
                                                       print(doc['name'][index]);
                                                        FirebaseFirestore.instance.collection('add Favorite').doc(doc['name'][index]).set({
                                                          'name':doc['name'][index],
                                                          'values':doc['values'][index],

                                                        });
                                                        print('Data is stored successfully');
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                            .toList());
                  } else if (snapshot.hasError) {
                    return Text('It');
                  }
                  return Text('usaa');
                }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCard('assets/images/food.jpg', 'Recommended'),
                      buildCard('assets/images/food.jpg', 'Low Calories'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCard('assets/images/food.jpg', 'From Doctors'),
                      buildCard('assets/images/food.jpg', 'Recommended'),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}
