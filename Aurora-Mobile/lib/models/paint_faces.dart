import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PaintFaces extends CustomPainter {
  final ui.Image image;
  final List<Face> facesList;
  final List<Rect> faceRectangles = [];

  PaintFaces(this.image, this.facesList) {
    for (var i = 0; i < facesList.length; i++) {
      faceRectangles.add(facesList[i].boundingBox);
    }
  }


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < facesList.length; i++) {
      canvas.drawRect(faceRectangles[i], paint);
    }
  }

  @override
  bool shouldRepaint(PaintFaces old) {
    return image != old.image || facesList != old.facesList;
  }
}