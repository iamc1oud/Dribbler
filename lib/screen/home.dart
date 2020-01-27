import 'package:dribbler_v2/screen/SubjectGrid.dart';
import 'package:flutter/material.dart';
import 'JustUploaded.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dribbler"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF1F204E), Color(0xFF114174),])),
        ),
      ),
      drawer: new SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: new Drawer(
          child: new ListView(physics: BouncingScrollPhysics(), children: [
            SizedBox(
              height: 30,
              child: new CircleAvatar(
                child: new Icon(Icons.ac_unit),
              ),
            ),
          ]),
        ),
      ),
      bottomSheet: new BottomSheet(
        onClosing: () {},
        elevation: 10,
        builder: (context) {
          return Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[new Icon(Icons.home), new Icon(Icons.favorite_border)],
            ),
          );
        },
      ),
    );
  }
}
