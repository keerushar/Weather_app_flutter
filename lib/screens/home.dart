import 'package:flutter/material.dart';
import 'package:weatherapp/models/citylocation.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/widgets/p_w_h.dart';
import 'package:weatherapp/widgets/weektemp.dart';

Weather? currentTemp;
Weather? todayTemp;
List<Weather>? sevenDay;
String lat = "27.7167";
String lon = "85.3167";
String city = "Kathmandu";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayTemp = value[1];
      sevenDay = value[2];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: currentTemp == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 90),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                        children: [TempBuilder()],
                      ),
                    ),
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade700,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Weather App",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CityEntryView(updateData: getData),
                  ],
                ),
              ),
            ),
    );
  }
}

class TempBuilder extends StatefulWidget {
  const TempBuilder({Key? key}) : super(key: key);

  @override
  _TempBuilderState createState() => _TempBuilderState();
}

class _TempBuilderState extends State<TempBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_sharp),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          city,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      currentTemp!.day!,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 160,
                child: Row(
                  children: [
                    getWeatherIcon(currentTemp!.icon!),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentTemp!.tempnow}°C",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                        ),
                        Text(
                          currentTemp!.desc!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "H: ${todayTemp!.high}°C   \nL: ${todayTemp!.low}°C",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        PWH(tempNow: currentTemp, tempToday: todayTemp),
        WeekTemp(
          tempWeek: sevenDay,
        )
      ],
    );
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 200,
      height: 200,
    );
  }
}

class CityEntryView extends StatefulWidget {
  final Function()? updateData;
  const CityEntryView({Key? key, this.updateData}) : super(key: key);

  @override
  _CityEntryViewState createState() => _CityEntryViewState();
}

class _CityEntryViewState extends State<CityEntryView> {
  bool updating = false;
  final textField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 70),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: TextField(
                controller: textField,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: "Search Location",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                  ),
                  prefixIcon: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: Icon(Icons.search),
                  ),
                  suffix: updating
                      ? Container(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator())
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                ),
                onSubmitted: (value) async {
                  setState(() {
                    updating = true;
                  });
                  CityLocation? temp = await fetchCity(value);
                  if (temp == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey,
                            title: Text(
                              "City not found",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              "Please check the city name",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    textField.clear();
                                    setState(() {
                                      updating = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Ok",
                                    style:
                                        TextStyle(color: Colors.pink.shade800),
                                  ))
                            ],
                          );
                        });
                    return;
                  }
                  city = temp.name!;
                  lat = temp.lat!;
                  lon = temp.lon!;
                  setState(() {});
                  textField.clear();

                  widget.updateData!()!;

                  setState(() {
                    updating = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
