import 'dart:async';
import 'package:database/database/db_handler.dart';
import 'package:database/model/model_notes.dart';
import 'package:database/screens/background/bg_add.dart';
import 'package:database/screens/home_screen.dart';
import 'package:database/utils/colors.dart';
import 'package:database/widgets/ctextfield.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late DBHelper dbHelper;

  var titleController = TextEditingController();
  var extraController = TextEditingController();
  var descController = TextEditingController();

  var error = " ";

  int? id;
  late String title;
  late String? extra;
  late String date;
  late String desc;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add a Note"),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          BackgroundAdd(height: height, width: width),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.05, horizontal: width * 0.08),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 30,
                ),
                cTextField(
                  label: "Title",
                  textController: titleController,
                ),
                const SizedBox(
                  height: 20,
                ),
                cTextField(label: "Extra", textController: extraController),
                const SizedBox(
                  height: 20,
                ),
                cTextField(
                  textController: descController,
                  keyboardType: TextInputType.multiline,
                  label: "Description*",
                  maxLines: 8,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      id = id;
                      title = titleController.text.toUpperCase().toString();

                      extra = extraController.text.toString();
                      desc = descController.text.toString();
                      date =
                          ("${DateTime.now().day.padLeft(2, '0')}/${DateTime.now().month.padLeft(2, '0')}/${DateTime.now().year}")
                              .toString();
                      if (title.isNotEmpty && desc.isNotEmpty) {
                        error = "Notes Added";
                        dbHelper
                            .insert(NotesModel(
                          id: id,
                          title: title,
                          extra: extra,
                          date: date,
                          description: desc,
                        ))
                            .then((value) {
                          print('data added');
                          print(date);
                          setState(() {});
                        }).onError((error, stackTrace) {
                          print(error.toString());
                        });
                        Timer(const Duration(seconds: 1), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        });
                      } else {
                        error = "Please Fill All Boxes";
                        // print("Please Fill All Boxes");
                        setState(() {});
                      }
                    },
                    child: const Text('Add Note')),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
