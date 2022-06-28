import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:time_zone_app/pages/list.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:convert';
import '../api.dart' as util;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Myapifile extends StatefulWidget {
   Myapifile({Key? key,required this.continentname,required this.countryname});
  String countryname;
  String continentname;

  @override
  State<Myapifile> createState() => _MyapifileState();
}

class _MyapifileState extends State<Myapifile> {

  late String countryname;
  late String continentname;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    continentname=widget.continentname;
    countryname=widget.countryname;
  }
  
     void showstuff() async{
    Map data=await gettime(util.continent,util.country);
    print(data.toString());
  }

  Future <Map> gettime(String continent,String country)async{
    String apiurl='https://worldtimeapi.org/api/timezone/$continent/$country';
    http.Response response=await http.get(Uri.parse(apiurl));
    return jsonDecode(response.body);
  }

 Widget updateTempwidget (value1,value2){
    return FutureBuilder(
       future: gettime(value1.toString()==''?util.continent:value1, value2.toString()==''?util.country:value2),
      builder: (BuildContext context,AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          Map? content=snapshot.data;
         // var iconcode=content!['weather'][0]['icon'];
         String dateTime = content!['datetime'];
         DateTime time = DateTime.parse(dateTime);
         String offset = content['utc_offset'].substring(1, 3);
         time = time.add(Duration(hours: int.parse(offset)));
    var timeStr = DateFormat('hh : mm a').format(time);
          return  Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: timeStr.substring(8,10)=='AM'?
                DecorationImage(image: AssetImage('lib/images/noon.png'),fit: BoxFit.fill):
                DecorationImage(image: AssetImage('lib/images/midnight.png'),fit: BoxFit.fill)
              ),
              child: Center(
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          
          
                          IconButton(
                            onPressed: (){                       
                             Navigator.push(
      context,
      PageTransition(
        duration: Duration(seconds: 1),
        type: PageTransitionType.fade,
        child: Mylistpage(),
        inheritTheme: true,
        ctx: context));
                            },
                           icon: Icon(CupertinoIcons.square_fill_line_vertical_square),                    
                          ),
          
          
                        Text(timeStr.substring(0, 10),
                        style:TextStyle(
                          fontSize:22,
                          fontWeight: FontWeight.bold
                        ) ,
                        ),
                      
                        
                                    Text(value2,
                                style:TextStyle(
                                  fontSize: 50
                                ) ,
                                ),
                         
                               
                      ],
                    ),
              ),
            ),
          );
            
        
        }
        else{
          return Container();
        }
      }
      );
  }

  @override
  Widget build(BuildContext context) {

    return updateTempwidget(continentname,countryname);
  }
}