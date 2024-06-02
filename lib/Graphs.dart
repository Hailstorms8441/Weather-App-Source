import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/forcast_service.dart';

class Graphs extends StatefulWidget {
  
  final Future<ForcastData> forcastData;
  const Graphs({super.key, required this.forcastData});

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FutureData> graphdata = []; 
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 87, 123, 141),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: FutureBuilder<ForcastData>(future: widget.forcastData, builder: (context, snapshot) {
        if (snapshot.hasData) {
          graphdata = [];
          for (var i = 0; i < 40; i++) {
            graphdata.add(FutureData(snapshot.data!.list[i].time.toString(), snapshot.data!.list[i].main.temp));
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 300.0, left: 5.0, right: 5.0),
              child: SfCartesianChart(
                
                plotAreaBorderColor: Colors.black,
                
              
                title: const ChartTitle(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    decoration: TextDecoration.underline
                  ),
                  text: "5 Day Forcast:"
                ),
              
                primaryXAxis: const CategoryAxis(
                  axisLine: AxisLine(color: Colors.black),
                  majorGridLines: MajorGridLines(color: Colors.black),
                  majorTickLines: MajorTickLines(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
              
                primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(color: Colors.black),
                  majorGridLines: MajorGridLines(color: Colors.black),
                  majorTickLines: MajorTickLines(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                // Enable legend
                legend: const Legend(
                  isVisible: true,
                  textStyle: TextStyle(color: Colors.black)
                ),
                
                //tooltipBehavior: _tooltipBehavior,
              
                trackballBehavior: TrackballBehavior(
                    // Enables the trackball
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  lineWidth: 2.0,
                  lineColor: const Color.fromARGB(255, 30, 30, 30),
                  tooltipSettings: const InteractiveTooltip(
                    enable: true,
                    format: 'point.x : point.y ° F',
                    color: Color.fromARGB(255, 30, 30, 30)
                  ),
                ),
                series: <LineSeries<FutureData, String>>[
                  LineSeries<FutureData, String>(
                    
                    name: 'Temp in °F',
                    dataSource:  graphdata,
                    xValueMapper: (FutureData sales, _) => sales.date,
                    yValueMapper: (FutureData sales, _) => sales.value,
                    // Enable data label
                    //dataLabelSettings: const DataLabelSettings(isVisible: false)
                  )
                ]
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },)
    );
  }
}


class FutureData {
  FutureData(this.date, this.value);
  final String date;
  final int value;
}