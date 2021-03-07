import 'dart:ui';

import 'package:flutter/material.dart';
import 'aboutinfo.dart';



List<AboutInfo> info=[
  AboutInfo(name:"Gehad karam",email: "Gogga1454@gmail.com",url: "assets/Gehad.jpeg"),
  AboutInfo(name:"Carol fadel",email: "Carol.1118056@stemmaadi.moe.edu.eg",url: "assets/Carol.jpeg"),
  AboutInfo(name:"Sara Shaker",email: "sarah.1118030@stemmaadi.moe.edu.eg",url: "assets/Sara.jpeg"),
];
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: info.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 4.0),
          child: ListTile(
            leading:CircleAvatar(
              backgroundImage:AssetImage(info[index].url),
              radius: 40,
            ),
            title: Text("Name:${info[index].name}",style:TextStyle(letterSpacing: 1.5,color: Colors.green)),
            subtitle: Text("E-mail:${info[index].email}"),
            onTap:(){} ,
          ),
        );
      },
      
    );
  }
}