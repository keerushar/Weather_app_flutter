import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';

class WeekTemp extends StatelessWidget {
  final List<Weather>? tempWeek;
  const WeekTemp({Key? key, this.tempWeek}) : super(key: key);
  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tempWeek!.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tempWeek![i].day.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Container(
                          child: Column(
                            children: [
                              getWeatherIconSmall(tempWeek![i].icon!),
                              Text(
                                tempWeek![i].desc.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "+" +
                                  tempWeek![i].high!.round().toString() +
                                  "\u00B0" +
                                  "/" +
                                  tempWeek![i].low!.round().toString() +
                                  "\u00B0",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
