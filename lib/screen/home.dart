import 'modulePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('subject').getDocuments().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              //return new Text('Loading...');
              default:
                return Stack(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF2a1a4c), Color(0xFF3e5588)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      right: 10,
                      bottom: 10,
                      child: new Text(
                        "Dribbler",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 50,
                          fontFamily: "Quicksand",
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 10,
                      left: 10,
                      bottom: 10,
                      child: Container(
                        child: new GridView.count(
                          crossAxisCount: 2,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: 1,
                          physics: BouncingScrollPhysics(),
                          children: snapshot.data.documents.map((DocumentSnapshot document) {
                            return InkWell(
                              onTap: () {
                                showBottomSheet(
                                    clipBehavior: Clip.antiAlias,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext ctx) => Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: ClipRRect(
                                            //borderRadius: BorderRadius.only(
                                            //  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                            child: new Container(
                                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                                              ////borderRadius: BorderRadius.only(
                                              //topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                              height: MediaQuery.of(context).size.height,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                                                child: Center(
                                                  child: ModulePicker(
                                                    array: document.data["module"],
                                                    subjectName: document.data["name"],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                                child: SizedBox(
                                  height: 70,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 70,
                                      minHeight: 60,
                                    ),
                                    child: new Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Stack(children: [
                                        Positioned(
                                          top: 40,
                                          left: 10,
                                          right: 10,
                                          child: new Text(
                                            document.data["name"],
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          right: 10,
                                          bottom: 40,
                                          child: new Text(
                                            document.data["module"].length.toString() + " Modules",
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: "Quicksand"),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
