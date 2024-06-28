import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageDetails extends StatelessWidget {
  final AssetEntity asset;

  const ImageDetails({super.key, required this.asset});

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

                List<String> deleted = await PhotoManager.editor.deleteWithIds([asset.id]);
                if(deleted.isNotEmpty){
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
              },
            )
          ],
        ),
        body: Center(
            child: FutureBuilder<Uint8List?>(
              future: asset.originBytes,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.contain,
                    );
                }
                  else{
                    return CircularProgressIndicator(color: Color(0xff98e0ff));
                  }
              }
            )));
  }
}
