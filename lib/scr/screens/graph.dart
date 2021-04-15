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

class Graphpoint {
  final int time;
  final double value;

  Graphpoint(this.time, this.value);
}

// void LoadModel() async {
//   String res = await Tflite.loadModel(
//       model: "assets/linear.tflite",
//       numThreads: 1, // defaults to 1
//       isAsset:
//           true, // defaults to true, set to false to load resources outside assets
//       useGpuDelegate:
//           false // defaults to false, set to true to use GPU delegate
//       );
//   print(res);
// }
var output;
var input = List(1 * 140).reshape([1, 140]);

List<String> val;
String contents;
File file;
Future<bool> getUpload() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
    file = File(result.files.single.path);
  } else {
    // User canceled the picker
  }
  file.readAsString().then((contents) {
    print(contents);
    //print(contents.split("  "));
    val = contents.split("  ");
    print(val[0]);
    print(val[1]);
    print(val[2]);
    int len = val.length;
    print(len);
    print(len);
    double l1 = len / 140;
    //var onePointOne = double.parse(val[2]);
    //print(onePointOne);
    runmodel(0);
  });
  return true;
}

void runmodel(int i) async {
  // LoadModel();
  print("output");
  print("output");
  print("output");
  final interpreter = await Interpreter.fromAsset('linear.tflite');
  print("output1");
  print("output1");
  print("output1");
  //var onePointOne = double.parse(val[2]);

  input = List(1 * 140).reshape([1, 140]);
  for (int j = 0; j < 140; j++) {
    double opoint = double.parse(val[j + 140 * i]);
    input[0][j] = opoint;
    //print(input[0][j]);
    print(opoint);
  }
  print("output2");
  print("output2");
  print("output2");
  output = List(1 * 140).reshape([1, 140]);
  print("output3");
  print("output3");
  print("output3");
  // inference
  interpreter.run(input, output);
  print("output4");
  print("output4");
  print("output4");
  print(input[0][0]);
  print(input[0][0]);
  print(input[0][0]);
  // print the output
  print("output");
  print("output");
  print("output");
  print(output);
  // print(output[0][139]);
  // print(output[0][139]);
  // print(output[0][139]);
}

String getResult() {
  String result;
  double error = 0;
  for (int i = 0; i < 140; i++) {
    double a = (input[0][i] - output[0][i]);
    double b;
    b = a.abs();
    error = error + b;
  }
  error = error / 140;
  double threshhold = 0.096;
  double max = 0.15;
  double per = max - threshhold;
  double p = (error - threshhold);
  double q = (p / per) * 100;
  int u = q.toInt();
  print(error);
  print(error);
  print(error);

  if (error > threshhold) {
    result = "Critical - " + u.toString() + " % ";
    if (u > 70) {}
  } else
    result = "Normal";
  // print(result);
  // print(result);
  // print(result);
  // print(result);
  return result;
}

getSeriesData1(int i) {
  runmodel(0);
  // if (output != null) {
  final data = [
    // new Graphpoint(i, i),
    for (int i = 0; i < 140; i++) new Graphpoint(i, input[0][i]),
  ];

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
getSeriesData() {
  // if (output != null) {
  final data = [
    // new Graphpoint(i, i),
    for (int i = 0; i < 140; i++) new Graphpoint(i, output[0][i]),
  ];

  List<charts.Series<Graphpoint, int>> series = [
    charts.Series(
        id: "Value",
        data: data,
        domainFn: (Graphpoint series, _) => series.time,
        measureFn: (Graphpoint series, _) => series.value,
        colorFn: (Graphpoint series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  output = null;
  input = null;
  return series;
  //}
}
