import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/screens/newsearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HeartDoc/scr/screens/doctor.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:hovering/hovering.dart';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;
import 'package:HeartDoc/scr/screens/plot.dart';

class Mediate extends StatefulWidget {
  final String search;
  // List<doctor> docs;
  // final int i;
  Mediate(this.search);
  @override
  _MediateState createState() => _MediateState();
}

class _MediateState extends State<Mediate> {
  @override
  Widget build(BuildContext context) {
    var found = [];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('patient').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Loading");
            int j = -1;
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (snapshot.data.documents[i]['name'] == widget.search) {
                // print(snapshot.data.documents[i]['name']);
                // print(snapshot.data.documents[i]['email']);
                // print("---------------------------------------------");
                // found.add(snapshot.data.documents[i]['email']);
                found.add(i);
                j = 1;
                // if (snapshot.data.documents[i]['Date-Status'] != "null")
                //   j = snapshot.data.documents[i]['Date-Status'].length;
                // print("----------------");
                // break;
                //List<String> items=List.from(userDocument['items']);
                // var k = snapshot.data.documents[i]['Date'][0].length;

              }
            }
            if (j <= 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: "No Records Found",
                        color: Colors.grey,
                        weight: FontWeight.w300,
                        size: 22,
                      ),
                    ],
                  )
                ],
              );
            } else {
              return ListView.builder(
                itemCount: found.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print("done");
                      print(found[index]);
                      changeScreenReplacement(context, newSearch(found[index]));
                    },
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Name :' +
                            snapshot.data.documents[found[index]]['name'] +
                            '     Email:' +
                            snapshot.data.documents[found[index]]['email'] +
                            '                 Doctor:' +
                            snapshot.data.documents[found[index]]['doctor']),

                        //),
                      ),
                    ),
                  );
                },
              );
              // return ListView(
              //   children: <Widget>[
              // // .builder(
              // //     itemCount: 2,
              // //     itemBuilder: (context, index) {
              //       //Card(
              //         child: ListTile(
              //           leading: Icon(Icons.person),
              //           title: Text("Fing")
              //           // Text('  Name :' +
              //           //     snapshot.data.documents[found[index]]['name'] +
              //           //     '       E-mail:' +
              //           //     snapshot.data.documents[found[index]]['email'],),
              //           // subtitle: Text('  Doctor:' +
              //           //     snapshot.data.documents[found[index]]['doctor'],
              //        // ),
              //       //)
              //       );
              //   ]
              //);
            }
          }
          // },
          ),
    );
  }
}
