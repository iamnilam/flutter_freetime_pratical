import 'package:flutter/material.dart';
import '../note.dart';
import '../database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  const NoteDetail({Key? key, required this.appBarTitle, required this.note})
      : super(key: key);

  @override
  State<NoteDetail> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priority = ['High', 'Low'];
  String appBarTitle;
  Note note;
  late DatabaseHelper helper; // Instantiate DatabaseHelper object

  NoteDetailState(this.note, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper(); // Initialize the DatabaseHelper object
    titleController.text = note.title;
    descriptionController.text = note.description;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6!;

    return WillPopScope(
      onWillPop: () async {
        moveToLastScr();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScr();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  //dropdown menu
                  child: ListTile(
                    leading: const Icon(Icons.low_priority),
                    title: DropdownButton<String>(
                      items: _priority.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                      value: getPriorityAsString(note.priority),
                      onChanged: (String? valueSelectedByUser) {
                        setState(() {
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      },
                    ),
                  ),
                ),
                // Second Element
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                    left: 15.0,
                  ),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      icon: Icon(Icons.title),
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                    left: 15.0,
                  ),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      icon: Icon(Icons.details),
                    ),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: Colors.red,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScr();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved successfully');
    } else {
      _showAlertDialog('Status', 'Problem saving Note');
    }
  }

  void _delete() async {
    moveToLastScr();
    if (note.id == null) {
      _showAlertDialog('Status', 'First add a note');
      return;
    }
    int result = await helper.deleteNote(note.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Note deleted successfully');
    } else {
      _showAlertDialog('Status', 'Error');
    }
  }

  void updatePriorityAsInt(String? value) {
    String priority = _priority[0];
    switch (value) {
      case 'High':
        priority = _priority[0];
        break;
      case 'Low':
        priority = _priority[1];
        break;
    }
    note.priority = _priority.indexOf(priority) + 1;
  }

  String getPriorityAsString(int value) {
    return _priority[value - 1];
  }

  void moveToLastScr() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
