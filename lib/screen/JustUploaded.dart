import 'package:flutter/material.dart';

class JustUploaded extends StatefulWidget {
  @override
  _JustUploadedState createState() => _JustUploadedState();
}

class _JustUploadedState extends State<JustUploaded> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Just uploaded"),
          new Container(
            height: 250,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                new Card(
                  child: new Container(
                    height: 70,
                    width: 150,
                    color: Colors.teal,
                    child: Center(
                      child: new Text("1"),
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    height: 70,
                    width: 150,
                    color: Colors.teal,
                    child: Center(
                      child: new Text("1"),
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    height: 70,
                    width: 150,
                    color: Colors.teal,
                    child: Center(
                      child: new Text("1"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
