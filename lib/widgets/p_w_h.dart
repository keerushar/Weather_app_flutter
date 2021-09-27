import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';

class PWH extends StatelessWidget {
  final Weather? tempNow;
  final Weather? tempToday;
  PWH({ this.tempNow, this.tempToday});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Pressure",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${tempNow!.pressure.toString()} hPA"),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Wind",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${tempNow!.wind.toString()} m/s"),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Humidity",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${tempNow!.humidity.toString()}%"),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Rain",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${tempToday!.chanceRain.toString()}%"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
