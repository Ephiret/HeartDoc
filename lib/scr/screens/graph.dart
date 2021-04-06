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
void runmodel() async {
  // LoadModel();
  print("output");
  print("output");
  print("output");
  final interpreter = await Interpreter.fromAsset('linear.tflite');
  print("output1");
  print("output1");
  print("output1");
  var input = [
    [
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22,
      1.23,
      6.54,
      7.81,
      3.22,
      2.22
    ]
  ];
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
  });
}

getSeriesData() {
  String f;
  int i = 0;
  // for (i = 0; contents[i] != '\n'; i++) {
  //   if (contents[i] != " ") f = f + contents[i];
  // }
  print(f);
  // int a=output[0][1];
  final data = [
    // new Graphpoint(i, i),
    for (int i = 0; i < 140;i++) new Graphpoint(i, output[0][i]),
    // new Graphpoint(1, output[0][1]),

    // new Graphpoint(2, a),
    // new Graphpoint(2, 1023),
    // new Graphpoint(3, 1019),
    // new Graphpoint(4, 1023),
    // new Graphpoint(5, 1019),
    // new Graphpoint(6, 1023),
    // new Graphpoint(7, 1019),
    // new Graphpoint(8, 1023),
    // new Graphpoint(9, 1019),
    // new Graphpoint(10, 1023),
    // new Graphpoint(11, 1019),
    // new Graphpoint(12, 1023),
    // new Graphpoint(13, 1019),
    // new Graphpoint(14, 1023),
    // new Graphpoint(15, 1018),
    // new Graphpoint(16, 1023),
    // new Graphpoint(17, 1019),
    // new Graphpoint(18, 1023),
    // new Graphpoint(19, 1019),
    // new Graphpoint(20, 1023),
    // new Graphpoint(21, 1019),
    // new Graphpoint(22, 1023),
    // new Graphpoint(23, 1019),
    // new Graphpoint(24, 1023),
    // new Graphpoint(25, 1019),
    // new Graphpoint(26, 1023),
    // new Graphpoint(27, 1019),
    // new Graphpoint(28, 1023),
    // new Graphpoint(29, 1019),
    // new Graphpoint(30, 1023),
    // new Graphpoint(31, 1019),
    // new Graphpoint(32, 1023),
    // new Graphpoint(33, 1019),
    // new Graphpoint(34, 1023),
    // new Graphpoint(35, 1019),
    // new Graphpoint(36, 1023),
    // new Graphpoint(37, 1019),
    // new Graphpoint(38, 1023),
    // new Graphpoint(39, 1019),
    // new Graphpoint(40, 1023),
    // new Graphpoint(41, 1019),
    // new Graphpoint(42, 1023),
    // new Graphpoint(43, 1019),
    // new Graphpoint(44, 1023),
    // new Graphpoint(45, 1019),
    // new Graphpoint(46, 1023),
    // new Graphpoint(47, 1019),
    // new Graphpoint(48, 1023),
    // new Graphpoint(49, 1023),
    // new Graphpoint(50, 1018),
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
