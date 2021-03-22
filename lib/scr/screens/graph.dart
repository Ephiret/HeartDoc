import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class Graphpoint {
  final int time;
  final int value;

  Graphpoint(this.time, this.value);
}

File file;
Future getUpload() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
    file = File(result.files.single.path);
  } else {
    // User canceled the picker
  }
}

getSeriesData() {
  final data = [
    new Graphpoint(0, 1023),
    new Graphpoint(1, 1019),
    new Graphpoint(2, 1023),
    new Graphpoint(3, 1019),
    new Graphpoint(4, 1023),
    new Graphpoint(5, 1019),
    new Graphpoint(6, 1023),
    new Graphpoint(7, 1019),
    new Graphpoint(8, 1023),
    new Graphpoint(9, 1019),
    new Graphpoint(10, 1023),
    new Graphpoint(11, 1019),
    new Graphpoint(12, 1023),
    new Graphpoint(13, 1019),
    new Graphpoint(14, 1023),
    new Graphpoint(15, 1018),
    new Graphpoint(16, 1023),
    new Graphpoint(17, 1019),
    new Graphpoint(18, 1023),
    new Graphpoint(19, 1019),
    new Graphpoint(20, 1023),
    new Graphpoint(21, 1019),
    new Graphpoint(22, 1023),
    new Graphpoint(23, 1019),
    new Graphpoint(24, 1023),
    new Graphpoint(25, 1019),
    new Graphpoint(26, 1023),
    new Graphpoint(27, 1019),
    new Graphpoint(28, 1023),
    new Graphpoint(29, 1019),
    new Graphpoint(30, 1023),
    new Graphpoint(31, 1019),
    new Graphpoint(32, 1023),
    new Graphpoint(33, 1019),
    new Graphpoint(34, 1023),
    new Graphpoint(35, 1019),
    new Graphpoint(36, 1023),
    new Graphpoint(37, 1019),
    new Graphpoint(38, 1023),
    new Graphpoint(39, 1019),
    new Graphpoint(40, 1023),
    new Graphpoint(41, 1019),
    new Graphpoint(42, 1023),
    new Graphpoint(43, 1019),
    new Graphpoint(44, 1023),
    new Graphpoint(45, 1019),
    new Graphpoint(46, 1023),
    new Graphpoint(47, 1019),
    new Graphpoint(48, 1023),
    new Graphpoint(49, 1023),
    new Graphpoint(50, 1018),
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
