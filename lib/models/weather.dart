import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final double? tempnow;
  final double? low;
  final double? high;
  final double? feelslike;
  final double? pressure;
  final double? humidity;
  final double? wind;
  final String? icon;
  final String? location;
  final String? day;
  final double? chanceRain;
  final String? desc;

  Weather(
      {this.pressure,
      this.humidity,
      this.location,
      this.wind,
      this.icon,
      this.tempnow,
      this.feelslike,
      this.low,
      this.high,
      this.chanceRain,
      this.day,
      this.desc});

  static Weather? fromJson(jsonDecode) {}
}

String apiKey = "076c7e3bef2293790056f015acf17fdc";

Future<List> fetchData(String lat, String lon, String city) async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$apiKey");
  var response = await http.get(url);

  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    final res = json.decode(response.body);

    var current = res["current"];
    Weather currentTemp = Weather(
      pressure: current["pressure"].toDouble(),
      tempnow: current["temp"].toDouble(),
      desc: current["weather"][0]["main"].toString(),
      day: DateFormat("EEE dd, MMM").format(date),
      wind: current["wind_speed"].toDouble(),
      humidity: current["humidity"].toDouble(),
      chanceRain: current["uvi"].toDouble(),
      location: city,
      icon: current["weather"][0]["icon"],
    );

    
    var daily = res["daily"][0];
    Weather todayTemp = Weather(
        high: daily["temp"]["max"].toDouble(),
        low: daily["temp"]["min"].toDouble(),
        chanceRain: daily["uvi"].toDouble());

    List<Weather> sevenDay = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);
      var temp = res["daily"][i];
      var hourly = Weather(
          high: temp["temp"]["max"].toDouble(),
          low: temp["temp"]["min"].toDouble(),
          icon: temp["weather"][0]["icon"],
          desc: temp["weather"][0]["main"].toString(),
          day: day);
      sevenDay.add(hourly);
    }
    return [currentTemp,todayTemp, sevenDay];
  }
  return [null, null,null];
}
