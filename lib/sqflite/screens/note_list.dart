import 'package:flutter/material.dart';
import 'dart:async';
import '../database_helper.dart';
import '../note.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note>? noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>.empty();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("LCO ToDo"),
        backgroundColor: Colors.purple,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https//learncodeonline.in/mascot.png",
              ),
            ),
            title: Text(
              noteList![position].title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            subtitle: Text(
              noteList![position].date,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.open_in_new,
                color: Colors.white,
              ),
              onTap: () {
                navigateToDetail(noteList![position], 'Edit Todo');
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return NoteDetail(appBarTitle: title, note: note);
      }),
    );

    if (result == true) {
      updateListView();
      // Perform desired operations after returning from NoteDetail screen
    }
  }

  void updateListView() async {
    final Database? database = await databaseHelper.initializeDatabase();
    if (database != null) {
      List<Note> noteList = await databaseHelper.getNoteList();
      setState(() {
        this.noteList = noteList;
        this.count = noteList.length;
      });
    }
  }
}
