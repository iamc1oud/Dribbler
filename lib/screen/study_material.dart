import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudyMaterial extends StatefulWidget {
  String module;
  String subjectName;

  StudyMaterial({Key key, String module, String subjectName}) {
    this.module = module;
    this.subjectName = subjectName;
  }
  @override
  _StudyMaterialState createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF2a1a4c), Color(0xFF3e5588)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 60,
                    child: new Text(
                      'Module ${widget.module}',
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontFamily: "Quicksand", fontSize: 50),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(widget.subjectName,
                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontFamily: "Quicksand", fontSize: 18)),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("upload")
                    .where("module", isEqualTo: widget.module)
                    .where("subject", isEqualTo: widget.subjectName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return Container(
                        height: 800,
                        child: new ListView(
                          physics: BouncingScrollPhysics(),
                          children: snapshot.data.documents
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: Colors.white)),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: new Text(e.data['title'].toString(),
                                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                                            ),
                                          ],
                                        )),
                                  ))
                              .toList(),
                        ),
                      );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
