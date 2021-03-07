
import 'package:Flutter_TM/about.dart';
import 'package:flutter/rendering.dart';

import './flutter_teachble.dart';
import 'package:flutter/material.dart';
import 'main.dart';
class HomePage extends StatelessWidget {
 
 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(100.0),
                    child: AppBar(
                      
             shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(50),
    ),
    ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Container(
                  height:30,
                  child: Text('Home',style: TextStyle(fontSize:20))
                  ),
                Container(
                  height:30,
                  child: Text('About',style: TextStyle(fontSize:20))
                  ),
               
              ],
            ),
            title: Text('Emotional',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
        ),
        body: TabBarView(
          children: [
           FlutterTeachable(cameras),
            About(),
           
          ],
        ),
      ),
    );
  }
}