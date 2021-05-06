import 'dart:async';

import 'package:HeartDoc/scr/models/patient.dart';
import 'package:HeartDoc/scr/screens/notification.dart';
import 'package:HeartDoc/scr/screens/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/app.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/screens/search.dart';
import 'package:HeartDoc/scr/screens/plot.dart';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    bool check = false;
    final _formKey = GlobalKey<FormState>();
    final _key = GlobalKey<FormState>();
    int l;
    TextEditingController username = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "HeartDoc",
          color: white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.orange, Colors.red]),
                color: primary,
              ),
              accountName: CustomText(
                text: "Admin",
                color: white,
                weight: FontWeight.bold,
                size: 25,
              ),
              accountEmail: CustomText(text: "Admin", color: white, size: 25),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Admin());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Divider(),
                    SizedBox(
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                    controller: username,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "E-mail",
                                                        icon:
                                                            Icon(Icons.email)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                    controller: name,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Name",
                                                        icon:
                                                            Icon(Icons.person)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                    controller: pass,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Password",
                                                        icon: Icon(Icons.lock)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(10),
                                            //   child: GestureDetector(
                                            //     onTap: () async {
                                            //       // changeScreenReplacement(context, Home());
                                            //     },
                                            //     child: Container(
                                            //       decoration: BoxDecoration(
                                            //           color: Colors.grey,
                                            //           border: Border.all(
                                            //               color: grey),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   15)),
                                            //       child: Padding(
                                            //         padding: EdgeInsets.only(
                                            //             top: 10, bottom: 10),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: <Widget>[
                                            //             CustomText(
                                            //               text: "Register",
                                            //               color: white,
                                            //               size: 22,
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                child: Text("Submit"),
                                                onPressed: () {
                                                  print(name);
                                                  print(username);
                                                  print(pass);
                                                  if (name.text != "" &&
                                                      pass.text != "" &&
                                                      username.text != "") {
                                                    if (username.text
                                                        .contains("@")) {
                                                      if (adddoctor(
                                                              username.text,
                                                              name.text,
                                                              pass.text) ==
                                                          true) {
                                                        print("done");
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Doctor added"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Ok'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Doctor with same username exists"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Ok'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }

                                                      username.text = "";
                                                      name.text = "";
                                                      pass.text = "";
                                                    }
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Register a new Doctor",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                    controller: username,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "E-mail",
                                                        icon:
                                                            Icon(Icons.email)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(10),
                                            //   child: GestureDetector(
                                            //     onTap: () async {
                                            //       // changeScreenReplacement(context, Home());
                                            //     },
                                            //     child: Container(
                                            //       decoration: BoxDecoration(
                                            //           color: Colors.grey,
                                            //           border: Border.all(
                                            //               color: grey),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   15)),
                                            //       child: Padding(
                                            //         padding: EdgeInsets.only(
                                            //             top: 10, bottom: 10),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: <Widget>[
                                            //             CustomText(
                                            //               text: "Register",
                                            //               color: white,
                                            //               size: 22,
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                child: Text("Submit"),
                                                onPressed: () {
                                                  print(name);
                                                  print(username);
                                                  print(pass);
                                                  if (username.text != "") {
                                                    if (username.text
                                                        .contains("@")) {
                                                      if (removedoctor(
                                                              username.text,
                                                              ) ==
                                                          true) {
                                                        print("done");
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Doctor removed"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Ok'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "No Doctor with this username exists"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Ok'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }

                                                      username.text = "";
                                                      name.text = "";
                                                      pass.text = "";
                                                    }
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Remove a Doctor",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
//
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
