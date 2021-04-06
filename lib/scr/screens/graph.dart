import 'dart:ffi';

import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
// import 'package:matrix2d/matrix2d.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

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
var input;

List<String> val;
String contents;
File file;
Future getUpload() async {
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
    //var onePointOne = double.parse(val[2]);
    //print(onePointOne);
    runmodel();
  });
}

int i = 0;
void runmodel() async {
  // LoadModel();
  print("output");
  print("output");
  print("output");
  final interpreter = await Interpreter.fromAsset('linear.tflite');
  print("output1");
  print("output1");
  print("output1");
  //var onePointOne = double.parse(val[2]);
  //int len = val.length;
  input = List(1 * 140).reshape([1, 140]);
  for (int j = 0; j < 140; j++) {
    double opoint = double.parse(val[j + 420]);
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
  print(output[0][139]);
  print(output[0][139]);
  print(output[0][139]);
}

String getResult() {
  String result;
  double error = 0;
  for (int i = 0; i < 140; i++) {
    error = (input[0][i] - output[0][i]) * (input[0][i] - output[0][i]);
  }
  error = error / 140;
  double threshhold = 0.13;
  print(error);
  print(error);
  print(error);

  if (error > threshhold)
    result = "Critical";
  else
    result = "Normal";
  // print(result);
  // print(result);
  // print(result);
  // print(result);
  return result;
}

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

  return series;
  //}
}
