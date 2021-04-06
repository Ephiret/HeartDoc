import 'package:HeartDoc/scr/models/patient.dart';
import 'package:HeartDoc/scr/screens/notification.dart';
import 'package:HeartDoc/scr/screens/record.dart';
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

class Plot extends StatefulWidget {
  @override
  _PlotState createState() => _PlotState();
}

class _PlotState extends State<Plot> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    bool check = false;
    String result = getResult();
    // // final categoryProvider = Provider.of<CategoryProvider>(context);
    // // final restaurantProvider = Provider.of<RestaurantProvider>(context);
    // // final productProvider = Provider.of<ProductProvider>(context);
    // restaurantProvider.loadSingleRestaurant()
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "HeartDoc",
          color: white,
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
          : SafeArea(
              child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomText(
                      text: "Graphical Presentations",
                      size: 20,
                      color: grey,
                    ),
                  ],
                ),
              ),
              // if(check==true)
              // getprediction();

              SizedBox(
                width: 80,
                height: 220,
                child: Column(children: <Widget>[
                  Expanded(
                    child: new charts.LineChart(
                      getSeriesData(),
                      animate: true,
                      primaryMeasureAxis: new charts.NumericAxisSpec(
                          tickProviderSpec:
                              new charts.BasicNumericTickProviderSpec(
                        zeroBound: false,
                      )),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomText(
                      text: "Result",
                      size: 20,
                      color: grey,
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 80,
                  height: 220,
                  child: Column(
                    children: <Widget>[
                      CustomText(
                        text: result,
                        color: red,
                        size: 20,
                      )
                    ],
                  )),
            ])),
    );
  }
}
