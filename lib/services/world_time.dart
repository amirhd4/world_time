import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; // location name for the UI
  String? time; // the name in that location
  String? flag; // url to an asset flag icon
  String? url; // location url for api endpoint
  bool? isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get(
          Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = (data['utc_offset']).substring(1, 3);
      String offsetM = (data['utc_offset']).substring(4, 6);

      //create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offsetM)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      debugPrint('caught error: $e');
      time = 'could not get time data';
    }
  }
}