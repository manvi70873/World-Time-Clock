import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_zone_app/list/catalog.dart';
import 'package:time_zone_app/pages/myapifile.dart';
import 'package:page_transition/page_transition.dart';

class Mylistpage extends StatefulWidget {
  const Mylistpage({super.key});

  @override
  State<Mylistpage> createState() => _MylistpageState();
}

class _MylistpageState extends State<Mylistpage> {
  @override

void initState() {
    super.initState();
    loaddata();
  }


  loaddata() async{
  await Future.delayed(Duration(seconds: 2));
final catalogjson= await  rootBundle.loadString("lib/list/List.json");
final decoderdata=jsonDecode(catalogjson);
var productdata=decoderdata["items"];
catalog.items = List.from(productdata)
        .map<item>((items) => item.fromMap(items))
        .toList();
setState(() {});
}


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: (catalog.items!=null && catalog.items.isNotEmpty)?
      ListView.builder(
        itemCount: catalog.items.length,
        itemBuilder: (context,index){
           var item= catalog.items[index];
           return Card(
            color: Colors.deepPurple,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.all(
         Radius.circular(16.0),
       ),
     ),
             child: ListTile(
              title: Text(item.continentname,style: TextStyle(color: Colors.white),),
              subtitle: Text(item.countryname,style: TextStyle(color: Colors.white),),
              onTap: (){
                Navigator.push(
      context,
      PageTransition(
        duration: Duration(seconds: 1),
        type: PageTransitionType.fade,
        child: Myapifile(continentname: item.countryname,countryname: item.continentname,),
        inheritTheme: true,
        ctx: context),
);
             
              },
             ),
           );
        }
        )
        :Center(
         child: CircularProgressIndicator(
          color: Colors.deepPurple,
         ),
         ),
    );
  }
}