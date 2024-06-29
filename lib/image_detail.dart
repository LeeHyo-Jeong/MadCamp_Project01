import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageView extends StatefulWidget {
  final List<AssetEntity> assets;
  final int initialIndex;

  const ImageView({super.key, required this.assets, required this.initialIndex});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController _pageController;

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  void _deleteImage(BuildContext context, final currentIndex) async {
    List<String> deleted = await PhotoManager.editor.deleteWithIds(
        [widget.assets[currentIndex].id]);
    if (deleted.isNotEmpty) {
      // 삭제 성공 시 true 반환해서 리스트 갱신하도록 함
      Navigator.pop(context, true);
      // 삭제가 되었음을 알리는 toast (알람)
      Fluttertoast.showToast(
          msg: "Image deleted !",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,

          fontSize: 17,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete the image')),
      );
    }
  }

  void _deleteImageConfirmDialog(BuildContext context, final currentIndex){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Text("Delete Image"),
          content: Text("Are you sure you want to delete this image?"),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.black54,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete",
                  style: TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                _deleteImage(context, currentIndex);
                Navigator.pop(context, true);
                Fluttertoast.showToast(
                    msg: "Image deleted !",
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    fontSize: 17,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT);
              },
            )
          ]
        );
      }
    );
  }

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
          actions: [
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: Colors.red,),
              onPressed: () async{
                final currentIndex = _pageController.page?.toInt() ?? widget.initialIndex;
                _deleteImageConfirmDialog(context, currentIndex);
              },
            )
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
            itemCount: widget.assets.length,
            itemBuilder: (context, index) {
              return FutureBuilder<Uint8List?>(
                  future: widget.assets[index].originBytes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
                      );
                    }
                    else {
                      return CircularProgressIndicator(
                          color: Color(0xff98e0ff));
                    }
                  }
              );
            }
          ),
    );
  }
  }

