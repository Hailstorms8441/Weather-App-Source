import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';
import 'package:weather_app/current_block.dart';
import 'package:weather_app/Graphs.dart';
import 'package:weather_app/yellow.dart';
import 'package:weather_app/blue.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool canopen = true;
  String keyIsFirstLoaded = '';
  List<String> favcities = ["Portland,ME,US"];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String apikey = '';
  double lat = 43.6610277;
  double lon = -70.2548596;
  String curCity = 'Portland,ME,US';
  late Future<WeatherData> futureWeather;
  final cityController = TextEditingController();
  final apiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      keyIsFirstLoaded = 'is_first_loaded';
      futureWeather = WeatherService().getData(lon.toString(), lat.toString(), apikey);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 52, 76, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 7, 80),
        foregroundColor: Colors.white,
        title: const Text('Weather App'),
        leading: IconButton(
          onPressed: () {
            if(scaffoldKey.currentState!.isDrawerOpen){
              scaffoldKey.currentState!.closeDrawer();
            }else{
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: Tab(icon: Image.asset("assets/images/menu.png"))
        )
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 52, 76, 100),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 36, 7, 80)
              ),
              child: Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white
                  ),
                  'City Selection'
                )
              )
            ),
            ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                  child: Text(
                    'Current city: $curCity',
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Enter A City In City, State, Country Format', style: TextStyle(fontSize: 15.0, color: Colors.black),)
                    ),
                    style: const TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: cityController,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: FilledButton(
                    onPressed: () {
                      returncityval(cityController.text);
                      setState(() {
                        curCity = cityController.text;
                      });
                      cityController.clear();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                      foregroundColor: Colors.black
                    ),
                    child: const Text('Set City'),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: FilledButton(
                    onPressed: () {
                      returncityval(cityController.text);
                      setState(() {
                        if (favcities.contains(cityController.text)) {

                        } else {
                          curCity = cityController.text;
                          favcities.add(cityController.text);
                        }
                      });
                      cityController.clear();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                      foregroundColor: Colors.black
                    ),
                    child: const Text('Add As Favourite'),
                  )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Text(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                    ),
                    'Favourites:'
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: favcities.length.toDouble() * 50.0,
                  child: ListView.builder(
                    itemCount: favcities.length,
                    itemBuilder: (context, index) {
                      final item = favcities[index];
                      return ListTile(
                        title: Text(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          item
                        ),
                        onTap: () {
                          returncityval(item);
                          setState(() {
                            curCity = item;
                          });
                        }
                      );
                    }
                  )
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 15.0),
                  child: FilledButton(
                    onPressed: () => setState(() {
                      futureWeather = WeatherService().getData(lon.toString(), lat.toString(), apikey);
                      Navigator.pop(context);
                    }),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                      foregroundColor: Colors.black
                    ),
                    child: const Text('Refresh Weather'),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
                  child: FilledButton(
                    onPressed: () {
                      showDialogIfLoaded(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                      foregroundColor: Colors.black
                    ),
                    child: const Text('Set Api Key'),
                  )
                )
              ],
            )
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        crossAxisCount: 2,
        childAspectRatio: (2.24/1),
        children: [CurrentBlock(weatherData: futureWeather), const Red(), const Blue(), const Yellow()],)//Column(
    );
  }

  returncityval(incity) async{
    try {
      var response = await Dio()
        .get('http://api.openweathermap.org/geo/1.0/direct?q=$incity&limit=1&appid=$apikey');
      lat = response.data[0]['lat'];
      lon = response.data[0]['lon'];
      curCity = incity;
    } catch (e) {
      throw Exception('lon lat exeption was tripped');
    }

  }
  
  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    prefs.setBool(keyIsFirstLoaded, true);
    if (isFirstLoaded == true && canopen == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: const Text("Enter your API key here:"),
            backgroundColor: const Color.fromARGB(255, 52, 76, 100),
            content:TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  style: TextStyle(
                    color: Color.fromARGB(255, 20, 20, 20)
                  ),
                  'Make sure you input the correct key'
                )
              ),
              style: const TextStyle(fontSize: 20.0, color: Colors.black),
              controller: apiController,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ElevatedButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                  foregroundColor: Colors.black
                ),
                onPressed: () {
                  if (apiController.text == '') {

                  } else {
                  // Close the dialog
                    setState(() {
                      apikey = apiController.text;
                    });
                    setState(() {
                      futureWeather = WeatherService().getData(lon.toString(), lat.toString(), apikey);
                    });
                    apiController.clear();
                    Navigator.of(context).pop();
                    prefs.setBool(keyIsFirstLoaded, false);
                    canopen = false;
                  }
                },
                child: const Text("Set And Close"),
              ),
            ],
          );
        },
      );
    }
  }

  showDialogIfLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    prefs.setBool(keyIsFirstLoaded, true);
    if (isFirstLoaded == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: const Text("Enter your API key here:"),
            backgroundColor: const Color.fromARGB(255, 52, 76, 100),
            content:TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  style: TextStyle(
                    color: Color.fromARGB(255, 20, 20, 20)
                  ),
                  'Make sure you input the correct key'
                )
              ),
              style: const TextStyle(fontSize: 20.0, color: Colors.black),
              controller: apiController,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ElevatedButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 166, 161),
                  foregroundColor: Colors.black
                ),
                onPressed: () {
                  if (apiController.text == '') {

                  } else {
                  // Close the dialog
                    setState(() {
                      apikey = apiController.text;
                    });
                    setState(() {
                      futureWeather = WeatherService().getData(lon.toString(), lat.toString(), apikey);
                    });
                    apiController.clear();
                    Navigator.of(context).pop();
                    prefs.setBool(keyIsFirstLoaded, false);
                    canopen = false;
                  }
                },
                child: const Text("Set And Close"),
              ),
            ],
          );
        },
      );
    }
  }
}
