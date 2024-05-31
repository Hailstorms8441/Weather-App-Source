import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/forcast_service.dart';

class Graphs extends StatelessWidget {
  final Future<ForcastData> forcastData;
  const Graphs({super.key, required this.forcastData});

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior;
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 87, 123, 141),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: FutureBuilder<ForcastData>(future: forcastData, builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(style: const TextStyle(fontSize: 39), "Current Temp: ${snapshot.data!.list[0].main.temp.toInt()}° F")
            ],
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
  final double value;
}