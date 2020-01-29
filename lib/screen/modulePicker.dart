import 'package:flutter/material.dart';
import 'study_material.dart';

class ModulePicker extends StatefulWidget {
  List<dynamic> list;
  String subjectName;
  ModulePicker({List<dynamic> array, String subjectName}) {
    this.list = array;
    this.subjectName = subjectName;
  }

  @override
  _ModulePickerState createState() => _ModulePickerState();
}

class _ModulePickerState extends State<ModulePicker> {
  @override
  Widget build(BuildContext context) {
    print(widget.list);
    return ListView(
      addRepaintBoundaries: true,
      physics: BouncingScrollPhysics(),
      children: widget.list
          .map((f) => Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            maintainState: true,
                            builder: (context) => StudyMaterial(
                                  module: f,
                                  subjectName: widget.subjectName,
                                )));
                  },
                  child: SizedBox(
                    height: 100,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 5.0,
                        color: Colors.black.withOpacity(0.9),
                        child: Center(
                            child: new Text(
                          "Module ${f}",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
