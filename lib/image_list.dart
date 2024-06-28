import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:madcamp_project01/image_detail.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  List<AssetEntity> _mediaList = [];

  @override
  void initState(){
    super.initState();
    _loadMedia();
  }

  Future<void> _loadMedia() async{
    // 갤러리 접근 권한 요청
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    // 권한 허용 되었다면 갤러리로부터 이미지 fetch
    if(ps.isAuth){
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        // 이미지 앨범만 가져온다
          type: RequestType.image
      );

      //List<AssetEntity> media = await albums[0].getAssetListPaged(page: 0, size: 100);
      // 갤러리의 모든 사진 가져오기
      final AssetPathEntity album = albums.first;
      int imageCount = await album.assetCountAsync;
      List<AssetEntity> media = await album.getAssetListRange(
        start: 0,
        end: imageCount,
      );

      // _mediaList 업데이트 하고 UI 다시 빌드
      setState(() {
        _mediaList = media;
      });
    }
    // 권한이 허용되지 않은 경우 설정 화면을 연다
    else{
      await PhotoManager.openSetting();
    }
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mediaList.isEmpty
          ? Center(child:CircularProgressIndicator(color: Color(0xff98e0ff)))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5,
        ),
        itemCount: _mediaList.length,
        itemBuilder: (context, index){
          return FutureBuilder<Uint8List?>(
            future: _mediaList[index].thumbnailData,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                return GestureDetector(
                    onTap: () async{
                      Uint8List? imageData = await _mediaList[index].originBytes;
                      if(imageData != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageDetails(imageData: imageData)
                          )
                        );
                      }
                    },
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  )
                );
              }
              else{
                return Center(
                    child: CircularProgressIndicator(color: Color(0xff98e0ff)));
              }
            },
          );
        },
      ),
    );
  }
}