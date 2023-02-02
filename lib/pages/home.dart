import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context) != null
            ? ModalRoute.of(context)?.settings.arguments as Map
            : {};

    debugPrint(data.toString());

    // set background
    String bgImage = data['isDayTime'] != null && data['isDayTime']
        ? 'day.jpg'
        : 'night.jpg';
    Color? bgColor = data['isDayTime'] != null && data['isDayTime']
        ? Colors.blueAccent
        : Colors.grey[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result["flag"]
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location,
                        color: bgImage.startsWith("day")
                            ? Colors.black
                            : Colors.white),
                    label: Text('Edit Location',
                        style: TextStyle(
                            color: bgImage.startsWith("day")
                                ? Colors.black
                                : Colors.white))),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: bgImage.startsWith("day")
                              ? Colors.black
                              : Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                      fontSize: 66.0,
                      color: bgImage.startsWith("day")
                          ? Colors.black
                          : Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
