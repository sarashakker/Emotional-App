import 'package:Flutter_TM/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashScreen extends StatefulWidget {
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   

  @override
  void initState() {
    
    super.initState();
    Future.delayed(Duration(seconds:4),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage()));  
    });
  
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
                    
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:180.0,),
                  Image.asset('assets/Emo.png',width: 150,height:150,),
                  SizedBox(height:180),
                  SpinKitChasingDots(
                      color: Colors.green,
                      size: 35.0
                  )
                ],
              ),
                    ),
        
      );
  }
}