import 'dart:async';
import 'package:database/database/db_handler.dart';
import 'package:database/model/model_notes.dart';
import 'package:database/screens/background/bg_add.dart';
import 'package:database/screens/home_screen.dart';
import 'package:database/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EditNotes extends StatefulWidget {
  final int? id;
  final String title;
  final String? extra;
  final String date;

  final String desc;

  const EditNotes(
      {super.key,
      required this.id,
      required this.title,
      this.extra,
      required this.date,
      required this.desc});

  @override
  State<EditNotes> createState() =>
      // ignore: no_logic_in_create_state
      EditNotesState(
          id: id, title: title, extra: extra, date: date, desc: desc);
}

class EditNotesState extends State<EditNotes> {
  late DBHelper dbHelper;
  late Future<List<NotesModel>>? notesList;

  var titleController = TextEditingController();
  var extraController = TextEditingController();
  var descController = TextEditingController();

  var error = " ";

  int? id;
  String title;
  String? extra;
  String date;
  String desc;

  EditNotesState(
      {required this.id,
      required this.title,
      this.extra,
      required this.date,
      required this.desc});

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();
    loadData();
    titleController = TextEditingController(text: title);
    extraController = TextEditingController(text: extra);
    descController = TextEditingController(text: desc);
  }

  loadData() async {
    notesList = dbHelper.getNotesList();
  }

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Edit Note"),
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            BackgroundAdd(height: height, width: width),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.05, horizontal: width * 0.08),
              child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleField(),
                      extraField(),
                      descField(),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor)),
                          onPressed: () {
                            title =
                                titleController.text.toUpperCase().toString();
                            extra = extraController.text.toString();
                            desc = descController.text.toString();
                            date =
                                ("${DateTime.now().day.padLeft(2, '0')}/${DateTime.now().month.padLeft(2, '0')}/${DateTime.now().year}")
                                    .toString();

                            if (title.isNotEmpty && desc.isNotEmpty) {
                              error = "Notes Updated";

                              dbHelper
                                  .update(NotesModel(
                                id: id,
                                title: title,
                                extra: extra,
                                date: date,
                                description: desc,
                              ))
                                  .then((value) {
                                // print('data Updated');
                                // print(id);
                                setState(() {
                                  notesList = dbHelper.getNotesList();
                                });
                              }).onError((error, stackTrace) {
                                print(error.toString());
                              });

                              Timer(const Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              });
                            } else {
                              error = "Please Fill All Boxes";
                              // print("Please Fill All Boxes");
                              setState(() {});
                            }
                          },
                          child: const Text('Update')),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  titleField() {
    return SizedBox(
      height: height * 0.12,
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
          label: const Text('Title*'),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  extraField() {
    return SizedBox(
      height: height * 0.12,
      child: TextField(
        controller: extraController,
        decoration: InputDecoration(
          label: const Text('Extra'),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  descField() {
    return SizedBox(
      height: height * 0.35,
      child: TextField(
        controller: descController,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        decoration: InputDecoration(
          label: const Text('Description*'),
          alignLabelWithHint: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
