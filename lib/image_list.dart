import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:madcamp_project01/image_detail.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {

  final ImagePicker _picker = ImagePicker();

  bool _isDisposed = false;

  List<AssetEntity> _mediaList = [];
  final ScrollController _scrollContoller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMedia();
  }

  Future<void> _pickImageFromCamera() async{
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if(photo != null){
      await PhotoManager.editor.saveImageWithPath(photo.path, title: "Captured Image");
      _loadMedia();
    }
  }
  Future<void> _loadMedia() async {
    // 갤러리 접근 권한 요청
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    // 권한 허용 되었다면 갤러리로부터 이미지 fetch
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
          // 이미지 앨범만 가져온다
          type: RequestType.image);

      // 갤러리의 모든 사진 가져오기
      final AssetPathEntity album = albums.first;
      int imageCount = await album.assetCountAsync;
      List<AssetEntity> media = await album.getAssetListRange(
        start: 0,
        end: imageCount,
      );

      // _mediaList 업데이트 하고 UI 다시 빌드
      if(_isDisposed) return;
      setState(() {
        _mediaList = media;
      });
    }
    // 권한이 허용되지 않은 경우 설정 화면을 연다
    else {
      await PhotoManager.openSetting();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Colors.white : Colors.black,
          title: Text("Gallery"),
          centerTitle: true,
        ),
        body: Scaffold(
            body: _mediaList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xff98e0ff)))
                : DraggableScrollbar.arrows(
                    backgroundColor: Color(0xff98e0ff),
                    controller: _scrollContoller,
                    child: GridView.builder(
                      controller: _scrollContoller,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: _mediaList.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Uint8List?>(
                          future: _mediaList[index].thumbnailData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return GestureDetector(
                                  onTap: () async {
                                    bool? deleted = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageView(
                                            assets: _mediaList,
                                            initialIndex: index),
                                      ),
                                    );

                                    if (deleted == true) {
                                      // 이미지 리스트에서 삭제된 이미지를 제거
                                      if(_isDisposed) return;
                                      setState(() {
                                        _mediaList.removeAt(index);
                                      });
                                    }
                                  },
                                  child: Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  ));
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xff98e0ff)));
                            }
                          },
                        );
                      },
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImageFromCamera,
          shape: CircleBorder(),
          child: Icon(Icons.photo_camera,
          color: Colors.white),
          backgroundColor: Color(0xff98e0ff),
          splashColor: Colors.black38,
        )));
  }
}
