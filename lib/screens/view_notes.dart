import 'package:database/screens/background/bg_add.dart';
import 'package:database/screens/edit_notes.dart';
import 'package:database/utils/colors.dart';
import 'package:flutter/material.dart';

class ViewNotes extends StatelessWidget {
  final int? id;
  final String title;
  final String? extra;
  final String date;
  final String description;

  const ViewNotes({
    this.id,
    required this.title,
    this.extra,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  print(id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNotes(
                              id: id,
                              title: title,
                              extra: extra,
                              date: date,
                              desc: description)));
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
        body: Stack(
          children: [
            BackgroundAdd(height: height, width: width),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.03),
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Date: \n',
                          style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        dateField(date, width * 0.045),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    extra!.isEmpty
                        ? const SizedBox(
                            height: 20,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Extra: \n',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              extraField(extra!),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                    const Text(
                      'Details: \n',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: descField(description),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dateField(String extra, double size) {
    return Row(
      children: [
        Text(
          '$date \n',
          style: TextStyle(
            fontSize: size,
          ),
        ),
      ],
    );
  }

  extraField(String extra) {
    return Row(
      children: [
        Text(
          '\t $extra \n',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  descField(String desc) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Center(
          child: Text(
            '\t $desc',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ));
  }
}
