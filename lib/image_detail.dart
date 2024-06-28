import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImageDetails extends StatelessWidget {
  final Uint8List imageData;

  const ImageDetails({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: Image.memory(
              imageData,
              fit: BoxFit.contain,
        )));
  }
}
