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
    List<FutureData> tempdata = []; 
    List<FutureData> raindata = [];
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 87, 123, 141),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: FutureBuilder<ForcastData>(future: widget.forcastData, builder: (context, snapshot) {
        if (snapshot.hasData) {
          tempdata = [];
          raindata = [];
          for (var i = 0; i < 40; i++) {
            raindata.add(FutureData(snapshot.data!.list[i].time.toString(), snapshot.data!.list[i].pop.toInt()));
          }
          for (var i = 0; i < 40; i++) {
            tempdata.add(FutureData(snapshot.data!.list[i].time.toString(), snapshot.data!.list[i].main.temp));
          }
          return Center(
            child: Column(
              children: [
                const Text('5 Day Forcast:', style: TextStyle(fontSize: 50.0, decoration: TextDecoration.underline)),
                SizedBox(
                  width: 800.0,
                  height: 299.0,
                  child: SfCartesianChart(
                    
                    plotAreaBorderColor: Colors.black,
                    
                    title: const ChartTitle(
                      textStyle: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline
                      ),
                      text: "Temperature:"
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
                        color: Colors.red,
                        name: 'Temp in °F',
                        dataSource:  tempdata,
                        xValueMapper: (FutureData data1, _) => data1.date,
                        yValueMapper: (FutureData data1, _) => data1.value,
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  width: 800.0,
                  height: 299.0,
                  child: SfCartesianChart(

                    isTransposed: true,
                    plotAreaBorderColor: Colors.black,

                    title: const ChartTitle(
                      textStyle: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline
                      ),
                      text: "Precipitation Chance: "
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
                      maximum: 100.0,
                    ),
                    // Enable legend
                    legend: const Legend(
                      isVisible: true,
                      textStyle: TextStyle(color: Colors.black)
                    ),
                    
                    trackballBehavior: TrackballBehavior(
                        // Enables the trackball
                      enable: true,
                      activationMode: ActivationMode.singleTap,
                      lineWidth: 2.0,
                      lineColor: const Color.fromARGB(255, 30, 30, 30),
                      tooltipSettings: const InteractiveTooltip(
                        enable: true,
                        format: 'point.x : point.y%',
                        color: Color.fromARGB(255, 30, 30, 30)
                      ),
                    ),

                    series: <BarSeries<FutureData, String>>[
                      BarSeries<FutureData, String>(
                        color: Colors.blue,
                        name: 'Precipitation %',
                        dataSource:  raindata,
                        xValueMapper: (FutureData data1, _) => data1.date,
                        yValueMapper: (FutureData data1, _) => data1.value,
                      ),
                    ]
                  ),
                ),
              ],
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