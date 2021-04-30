import 'dart:ffi';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
// import 'package:matrix2d/matrix2d.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
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
import 'package:HeartDoc/scr/screens/globals.dart' as globals;

class Graphpoint {
  final int time;
  final double value;

  Graphpoint(this.time, this.value);
}
var output;
var input = List(1 * 140).reshape([1, 140]);
List<String> val;
String contents;
File file;
Future<void> getUpload() async {
  globals.error = 0;
  input = null;
  output = null;
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
    file = File(result.files.single.path);
    await uploadFile(file.readAsBytesSync());
  } else {
    // User canceled the picker
  }
  file.readAsString().then((contents) {
    globals.check = true;
    // print(contents);
    //print(contents.split("  "));
    val = contents.split("  ");
    int len = val.length;
    double l1 = len / 140;
    int l = l1.toInt();
    globals.length = l;
    //var onePointOne = double.parse(val[2]);
    //print(onePointOne);
    runmodel(l);
  });
}

void runmodel(int i) async {
  // LoadModel();

  // print("output");
  // print("output");
  // print("output");
  final interpreter = await Interpreter.fromAsset('linear.tflite');
  // print("output1");
  // print("output1");
  // print("output1");
  output = List(i * 140).reshape([i, 140]);
  input = List(i * 140).reshape([i, 140]);
  //var onePointOne = double.parse(val[2]);
  for (int j = 0; j < i; j++) {
    for (int k = 0; k < 140; k++) {
      double opoint = double.parse(val[k + j * 140]);
      input[j][k] = opoint;
      //print(input[j][k]);
      //print(opoint);
    }
    // print("output2");
    // print("output2");
    // print("output2");
    // print("output3");
    // print("output3");
    // print("output3");
    // inference
    // print(input);
    // print(input);
    // print(input);
    var input1 = List(1 * 140).reshape([1, 140]);
    input1 = input[j];
    var output1 = List(1 * 140).reshape([1, 140]);
    interpreter.run(input1, output1);
    // print("output4");
    // print("output4");
    // print("output4");
    print(input[j]);
    // print(input[0][j]);
    // print(input[0][j]);
    // print the output
    output[j] = output1;
    // print("output1");
    // print("output1");
    // print("output1");
    print(output1);
    
  }
  // getResult();
}

// print(output[0][139]);
// print(output[0][139]);
// print(output[0][139]);
String getResult(int l) {
  //for (int l = 0; l < globals.length; l++) {
  String result;
  double error1 = 0;
  var out = List(1 * 140).reshape([1, 140]);
  out = output[l];
  var inp = List(1 * 140).reshape([1, 140]);
  inp = input[l];
  for (int i = 0; i < 140; i++) {
    double one = inp[i];
    double two = out[0][i];
    double and = (one - two);
    double band;
    band = and.abs();
    error1 = error1 + band;
  }
  error1 = error1 / 140;
  globals.error += error1;
  double threshhold = 0.067;
  double max = 0.12;
  double per = max - threshhold;
  double p = (error1 - threshhold);
  double q = (p / per) * 100;
  int u = q.toInt();
  print(error1);
  print(error1);
  print(error1);
  if (error1 > threshhold) {
    result = "Critical - " + u.toString() + " % ";
  } else
    result = "Normal";
  return result;
}

String getResult1(String email) {
  int l = globals.length;
  //for (int l = 0; l < globals.length; l++) {
  String result;
  double threshhold = 0.067 * l;
  double max = 0.12 * l;
  double per = max - threshhold;
  double p = (globals.error - threshhold);
  double q = (p / per) * 100;
  int u = q.toInt();
  // print(error1);
  // print(error1);
  // print(error1);
  if (globals.error > threshhold) {
    result = "Critical - " + u.toString() + " % ";
  } else
    result = "Normal";
  updatepatient(email, result);
  return result;
}
//   print(
//     "-----------------------------------------------------------------------------------------");
// print(globals.result[l]);
// print(
//     "-----------------------------------------------------------------------------------------");
// print(globals.result[l]);
// print(
//     "-----------------------------------------------------------------------------------------");
// print(globals.result[l]);
// print(
//     "-----------------------------------------------------------------------------------------");
// print(globals.result[l]);
// }

// print(result);
// print(result);
// print(result);
// print(result);
//}

getSeriesData1(int j) {
  final data = [
    for (int i = 0; i < 140; i++) new Graphpoint(i, input[j][i]),
  ];
  print("Done");
  print("Done");
  print("Done");

  // updatepatient(email, result);
  List<charts.Series<Graphpoint, int>> series = [
    charts.Series(
        id: "Value",
        data: data,
        domainFn: (Graphpoint series, _) => series.time,
        measureFn: (Graphpoint series, _) => series.value,
        colorFn: (Graphpoint series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  return series;
}

//}
getSeriesData(int j) {
  // if (output != null) {
  var output1 = List(1 * 140).reshape([1, 140]);
  output1 = output[j];
  final data = [
    for (int i = 0; i < 140; i++) new Graphpoint(i, output1[0][i]),
  ];
  print("Done");
  print("Done");
  print("Done");
  String result;
  // result = getResult();
  // updatepatient(email, result);
  List<charts.Series<Graphpoint, int>> series = [
    charts.Series(
        id: "Value",
        data: data,
        domainFn: (Graphpoint series, _) => series.time,
        measureFn: (Graphpoint series, _) => series.value,
        colorFn: (Graphpoint series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  //output[j] = null;
  return series;
}
