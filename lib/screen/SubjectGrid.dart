import 'package:flutter/material.dart';

class SubjectList extends StatefulWidget {
  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Subjects"),
          new Container(
            height: 250,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                new Card(
                  child: new Container(
                    height: 100,
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
