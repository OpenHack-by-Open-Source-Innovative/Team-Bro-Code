import 'dart:io';

import 'package:aurora/screens/facial_depression_detection_screen.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class FacialRecognitionConfirmationPage extends StatefulWidget {
  static const routeName = '/facial-recognition-confirmation-page';

  @override
  _FacialRecognitionConfirmationPageState createState() =>
      _FacialRecognitionConfirmationPageState();
}

class _FacialRecognitionConfirmationPageState extends State<FacialRecognitionConfirmationPage> {
 
  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    File _faceScanImageFile;
    List<Face> _faces;
    ui.Image _image;



    void loadingImage(File imagefile) async {
      final imageData = await imagefile.readAsBytes();
      await decodeImageFromList(imageData).then((decodedImageData) {
        setState(() {
          _image = decodedImageData;
        });
      });
      Navigator.of(context).pushNamed(FacialDepressionDetectionScreen.routeName, arguments: {
        'faceScanImageFile': _faceScanImageFile,
        'facesList': _faces,
        'loadedImageList' : _image,
      });
    }




    void facialDepressionDetection(File faceScanImage, BuildContext context) async {
      final image = FirebaseVisionImage.fromFile(faceScanImage);
      final faceDetector = FirebaseVision.instance.faceDetector(
        FaceDetectorOptions(
          mode: FaceDetectorMode.accurate,
          enableLandmarks: true,
        ),
      );
      await faceDetector.processImage(image).then((faces) {
        setState(() {
          _faceScanImageFile = faceScanImage;
          _faces = faces;
          loadingImage(faceScanImage);
        });
      });

    }




    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: mediaQuery.size.height * 0.08,
            ),
            Image.asset(
              "assets/images/conformationPage/facialRecognitionPage.png",
              width: mediaQuery.size.width * 0.7,
            ),
            SizedBox(
              height: 55,
            ),
            Center(
              child: Text(
                "Face Recognition",
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Scan your face and check your depression",
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.02,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.indigo.shade300],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
              child: new Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final faceScanImage = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      preferredCameraDevice: CameraDevice.front,
                    );
                    facialDepressionDetection(faceScanImage, context);
                  },
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
