import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HeartDoc/scr/screens/doctor.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';

class Search extends StatefulWidget {
  final String search;
  // List<doctor> docs;
  // final int i;
  Search(this.search);
  Firestore _firestore = Firestore.instance;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override

  //   dynamic patient;
  //   Future<dynamic> getPatientById(String id) =>
  //     Firestore.instance.collection('patient').document('Ayush').get().then((doc) {
  //       return patient.fromSnapshot(doc);
  //     });
  //   // Future<void> getPatient(id) async {
  //   //   final DocumentReference document =
  //   //       Firestore.instance.collection('patients').document('Ayush');
  //   //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //   //     setState(() {
  //   //       patient = snapshot.data;
  //   //     });
  //   //   });
  //   // }
  //   void initState() {
  //   super.initState();
  //   getPatientById("Ayush");
  // }

  @override
  Widget build(BuildContext context) {
    int i;
    print("Reached");
    print("Reached");
    print("Reached");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('patient').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          for (i = 0; i < snapshot.data.documents.length; i++) {
            if (snapshot.data.documents[i]['name'] == widget.search) {
              var j = snapshot.data.documents[i]['Date'].length;
              print(j);
              print(j);
              print(j);
              print(j);
              //List<String> items=List.from(userDocument['items']);
              // var k = snapshot.data.documents[i]['Date'][0].length;
              return Column(
                children: <Widget>[
                  Text("Name :" + snapshot.data.documents[i]['name']),
                  Text("Disease :" + snapshot.data.documents[i]['Disease']),
                  for (int l = 0; l < j; l++)
                    Text(snapshot.data.documents[i]['Date'][l] +
                        ":" +
                        snapshot.data.documents[i]['Status'][l]),
                  // for (int l = 0; l < j; l++)
                  //Text(),
                ],
              );
            }
          }
          // if (i == snapshot.data.documents.length) {
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
          // } else {

          // }
        },
      ),
    );
  }
}

//body: productProvider.productsSearched.length < 1? Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(Icons.search, color: grey, size: 30,),
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CustomText(text: "No products Found", color: grey, weight: FontWeight.w300, size: 22,),
//             ],
//           )
//         ],
//       ) : ListView.builder(
//           itemCount: productProvider.productsSearched.length,
//           itemBuilder: (context, index){
//             return GestureDetector(
//                 onTap: ()async{
//                   changeScreen(context, Details(product: productProvider.productsSearched[index]));
//                 },
//                 child: ProductWidget(product: productProvider.productsSearched[index]));
//           }),
//     );
//   }
// }
