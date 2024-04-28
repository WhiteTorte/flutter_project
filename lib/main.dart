import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenshot/flutter_screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bubble Screen Capture'),
      ),
      body: Center(
        child: BubbleWidget(),
      ),
    );
  }
}

class BubbleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _captureScreen(context),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Icon(Icons.touch_app, color: Colors.white),
        ),
      ),
    );
  }

  void _captureScreen(BuildContext context) async {
    final image = await FlutterScreenshot.capture();
    _saveImage(image);
  }

  Future<void> _saveImage(Uint8List image) async {
    try {
      final result = await ImageGallerySaver.saveImage(image);
      if (result['isSuccess']) {
        print('Image saved successfully');
        _showSnackBar(context, 'Image saved successfully');
      } else {
        print('Failed to save image: ${result['errorMessage']}');
        _showSnackBar(context, 'Failed to save image');
      }
    } catch (e) {
      print('Error saving image: $e');
      _showSnackBar(context, 'Error saving image');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
