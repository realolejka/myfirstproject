import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
void main () => runApp(
  MaterialApp(
    title: "Weather App",
    home: Home()
    ),
);



class Home extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}
class _HomeState extends State<Home>{

var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var apiUrl;
  String dropdownValue;

  Future getWeather () async{
    
    switch(this.dropdownValue){
      case 'Kyiv': apiUrl="http://api.openweathermap.org/data/2.5/weather?q=Kyiv&units=metric&appid=f4192de560dd24dacc0982c6418b58e5";
      break;
      case 'Kharkiv': apiUrl="http://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&appid=f4192de560dd24dacc0982c6418b58e5";
      break;
      case 'Dnipro': apiUrl="http://api.openweathermap.org/data/2.5/weather?q=Dnipro&units=metric&appid=f4192de560dd24dacc0982c6418b58e5";
      break;
      case 'Donetsk': apiUrl="http://api.openweathermap.org/data/2.5/weather?q=Donetsk&units=metric&appid=f4192de560dd24dacc0982c6418b58e5";
      break;
    }
    http.Response response = await http.get(apiUrl);
    

  
    
    
    var results = json.decode(response.body);
    setState((){
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  void initState (){
    this.dropdownValue = 'Kyiv';
    super.initState();
    this.getWeather();
    
  }


  @override
Widget build (BuildContext context){
  return Scaffold(
    body: Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 2.3,
        width: MediaQuery.of(context).size.width,
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0) ,
            child: DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.white),

      
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          
        });
        this.getWeather();
      },
      items: <String>['Kyiv', 'Kharkiv', 'Dnipro', 'Donetsk']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black)),
        
        );
      }).toList()),
            ),
             Text(
              temp != null ? temp.toString() + "°" : "Loading...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w400
              ),
              ),
               Padding(
            padding: EdgeInsets.only(top: 10.0) ,
            child: Text(
              currently != null ? currently.toString() : "Loading...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600
            ),
            ),
           
            ),
        ],),
      ),
      Expanded(
        child: Padding( padding: EdgeInsets.all(20.0), 
            child: ListView(
              children: <Widget>[
                ListTile(leading: FaIcon(FontAwesomeIcons.thermometerFull),
                title: Text("Temperature"),
                trailing: Text(temp != null ? temp.toString() + "°": "Loading..."),
                ),
                ListTile(leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(description != null ? description.toString() : "Loading..."),
                ),
                ListTile(leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing: Text(humidity != null ? humidity.toString() : "Loading..."),
                ),
                ListTile(leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading..."),
                )
                ],
            ),
        ),
      ),
      
    ],),
  );


}
}