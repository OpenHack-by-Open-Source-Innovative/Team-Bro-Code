import 'dart:io';

import 'package:aurora/models/paint_faces.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FacialDepressionDetectionScreen extends StatefulWidget {
  static const routeName = "/facial-depression-detection-screen";
  
  @override
  State<FacialDepressionDetectionScreen> createState() => _FacialDepressionDetectionScreenState();
}

class _FacialDepressionDetectionScreenState extends State<FacialDepressionDetectionScreen> {

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final mediaQuery = MediaQuery.of(context);

    File faceScanImageFile = routeArgs['faceScanImageFile'];
    List<Face> facesList = routeArgs['facesList'];
    ui.Image loadedImage = routeArgs['loadedImageList'];




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          faceScanImageFile != null ? Container(
            height: mediaQuery.size.height * 0.6,
            width: double.infinity,
            child: FittedBox(
              child: SizedBox(
                height: loadedImage.height.toDouble(),
                width: loadedImage.width.toDouble(),
                child: CustomPaint(
                  painter: PaintFaces(loadedImage, facesList),
                ),
              ),
            ),
          ):Container(),

        ],
      ),
    );
  }
}