// import 'package:http/http.dart';
// import 'dart:convert';

// class RandomFood {

//   final String foodName; // location name for UI
//   final String foodImage; // the time in that location
//   List list = List();

//   RandomFood({ this.foodName, this.foodImage });

//   Future<void> getInfo() async {
//     // make the request
//     final response =
//         await get('https://api.jsonbin.io/b/5eca6b01e91d1e45d110700a/3');
//     list  = jsonDecode(response.body) as List;

//     // get properties from json
//     foodName = list['food_name'] as String;
//     foodImage = list['food_image'] as String;
    
    
//   }

// }

// // WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
