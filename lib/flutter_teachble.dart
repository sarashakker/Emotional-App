import 'dart:io';

import './detect_screen.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class FlutterTeachable extends StatefulWidget {
  final List<CameraDescription> cameras;
  FlutterTeachable(this.cameras);
  @override
  _FlutterTeachableState createState() => _FlutterTeachableState();
}

class _FlutterTeachableState extends State<FlutterTeachable> {
  bool liveFeed = false;

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  bool _load = false;
  File _pic;
  List _result;
  String _confidence = "";
  String _emotion = "";

  String numbers = '';

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();

    _load = true;

    loadMyModel().then((v) {
      setState(() {
        _load = false;
      });
    });
  }

  loadMyModel() async {
    var res = await Tflite.loadModel(
        labels: "assets/labels.txt", model: "assets/model_unquant.tflite");

    print("Result after Loading the Model is : $res");
  }

  chooseImage() async {
    File _img = await ImagePicker.pickImage(source: ImageSource.camera);

    if (_img == null) return;

    setState(() {
      _load = true;
      _pic = _img;
      applyModelonImage(_pic);
    });
  }

  applyModelonImage(File file) async {
    var _res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _load = false;
      _result = _res;
      print(_result);
      String str = _result[0]["label"];

      _emotion = str.substring(2);
      _confidence = _result != null
          ? (_result[0]["confidence"] * 100.0).toString().substring(0, 2) + "%"
          : "";

      print(str.substring(2));
      print(
          (_result[0]["confidence"] * 100.0).toString().substring(0, 2) + "%");
      print("indexed : ${_result[0]["label"]}");
    });
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: !liveFeed
          ? Center(
              child: ListView(
                children: <Widget>[
                  _load
                      ? Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: size.width * 0.9,
                          height: size.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: _pic != null
                                    ? Image.file(
                                        _pic,
                                        width: size.width * 0.6,
                                      )
                                    : Container(),
                              ),
                              _result == null
                                  ? Container()
                                  : Text(
                                      "emotion : $_emotion\nConfidence: $_confidence"),
                            ],
                          ),
                        )
                ],
              ),
            )
          : Stack(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedButton(
              onPress: () {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetectScreen(
                                title: "live",
                              )));
                });
              },
              height: 50,
              width: 300,
              text: 'Live Feed',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              selectedBackgroundColor: Colors.green,
              backgroundColor: Colors.grey[20],
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 0,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedButton(
              onPress: () {
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    liveFeed = false;
                  });
                  chooseImage();
                });
              },
              height: 50,
              width: 300,
              text: 'Image Feed',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              selectedBackgroundColor: Colors.green,
              backgroundColor: Colors.grey[20],
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 0,
            ),
          ],
        ),
      ),
    );
  }
}
