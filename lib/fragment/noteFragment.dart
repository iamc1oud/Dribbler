import 'package:dribbler_v2/cacheManager/cache.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';

class NoteFragment extends StatefulWidget {
  final DocumentSnapshot ds;
  const NoteFragment({Key key, this.ds}) : super(key: key);

  @override
  _NoteFragmentState createState() => _NoteFragmentState();
}

class _NoteFragmentState extends State<NoteFragment> {
  CustomCacheManager cacheManager = CustomCacheManager();

  bool isDownloading = false;
  bool isDownloaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  void getStatus() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    isDownloaded = await mmkv.getBool(widget.ds.documentID + 'downloaded');
    print(isDownloaded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 200,
              padding: const EdgeInsets.all(8.0),
              child: new Text(widget.ds.data["title"].toString(),
                  overflow: TextOverflow.fade, style: TextStyle(color: Colors.white, fontSize: 20)),
            ),

            // When download starts
            isDownloading == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),

                    // Change it with some gif
                    child: Container(child: new Image.asset('assets/gifs/source.gif')),
                  )
                : new SizedBox(),
            isDownloaded
                ? IconButton(
                    icon: Icon(Icons.panorama_fish_eye),
                    onPressed: () async {
                      MmkvFlutter mmkv = await MmkvFlutter.getInstance();
                      String pathOfFile = await mmkv.getString(widget.ds.documentID);
                      print(pathOfFile);
                      OpenFile.open(pathOfFile);
                    },
                  )
                : new SizedBox(),
            IconButton(
              icon: new Icon(Icons.file_download),
              onPressed: () async {
                setState(() {
                  isDownloading = true;
                });

                MmkvFlutter mmkv = await MmkvFlutter.getInstance();
                print(widget.ds["url"]);

                Dio dio = new Dio();
                Response resp = await dio.post("https://api.dropboxapi.com/2/files/get_temporary_link",
                    data: {"path": widget.ds.data["path"]},
                    options: Options(headers: {
                      "Authorization": "Bearer A_j8bd3Z36AAAAAAAAAAcl7S3Ql3tdcSb3FEHKaz5tAmLrg2anj5-2H9zY7qn_y-",
                      "Content-Type": "application/json"
                    }));
                print(resp.data["link"]);
                var fetchedFile = cacheManager.getFile(resp.data["link"]);
                fetchedFile.listen((data) async {
                  print(data);
                  await mmkv.setString(widget.ds.documentID, data.file.path.toString());
                  print(data.file.path.toString());
                  await mmkv.setBool(widget.ds.documentID + 'downloaded', true);
                  getStatus();
                  setState(() {
                    isDownloading = false;
                  });
                });
              },
            )
          ],
        ));
  }
}
