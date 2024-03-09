import 'package:database/database/db_handler.dart';
import 'package:database/model/model_notes.dart';
import 'package:database/screens/add_notes.dart';
import 'package:database/screens/background/bg_home.dart';
import 'package:database/screens/view_notes.dart';
import 'package:database/utils/colors.dart';
import 'package:database/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  DBHelper? dbHelper;
  late Future<List<NotesModel>>? notesList;

  late int? id;
  late String title;
  late String? extra;
  String? date;
  late String desc;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Notes'),
          backgroundColor: primaryColor,
        ),
        drawer: const CDrawer(),
        body: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              BackgroundHome(height: height, width: width),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: notesList,
                        builder: (context,
                            AsyncSnapshot<List<NotesModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewNotes(
                                                  id: snapshot.data![index].id,
                                                  title: snapshot
                                                      .data![index].title,
                                                  extra: snapshot
                                                      .data![index].extra,
                                                  date: snapshot
                                                      .data![index].date,
                                                  description: snapshot
                                                      .data![index].description,
                                                )));
                                  },
                                  child: Dismissible(
                                    direction: DismissDirection.endToStart,
                                    background: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.01),
                                      child: Card(
                                        color: Colors.red[400],
                                        child: const Icon(Icons.delete),
                                      ),
                                    ),
                                    key: ValueKey<int>(
                                        snapshot.data![index].id!),
                                    onDismissed: (DismissDirection direction) {
                                      setState(() {
                                        dbHelper!
                                            .delete(snapshot.data![index].id!);
                                        notesList = dbHelper!.getNotesList();
                                        snapshot.data!
                                            .remove(snapshot.data![index]);
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.01),
                                      child: Card(
                                        elevation: width * 0.01,
                                        shadowColor: secondaryColor,
                                        child: ListTile(
                                            leading: Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.015),
                                              child: Text(snapshot
                                                  .data![index].date
                                                  .substring(0, 5)),
                                            ),
                                            title: Text(
                                              snapshot.data![index].title
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                snapshot
                                                    .data![index].description
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            trailing:
                                                const Icon(Icons.arrow_forward)

                                            // Text(snapshot.data![index].id.toString()),
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNotes()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class CDrawer extends StatelessWidget {
  const CDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: secondaryColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: width * 0.25,
                      height: width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.125),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage(logoDrawer),
                          )),
                    ),
                    const Text('Hi'),
                  ],
                )),
          ),

          // Container(
          //   color: Colors.grey,
          //   child: TabBar(
          //       controller: _tabController,
          //       unselectedLabelColor: Colors.black,
          //       labelColor: Colors.white,
          //       indicator: BoxDecoration(color: Colors.grey[600]),
          //       tabs: const [
          //         Tab(
          //           text: "Tab 1",
          //         ),
          //         Tab(
          //           text: "Tab 2",
          //         ),
          //       ]),
          // ),
          // Expanded(
          //   child: Container(
          //     color: Colors.white,
          //     child: TabBarView(controller: _tabController, children: const [
          //       Tab(
          //         text: 'Abc',
          //       ),
          //       Tab(
          //         text: 'Abc',
          //       ),
          //     ]),
          //   ),
          // ),

          const Column(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate Us'),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
              ListTile(
                leading: Icon(Icons.help_center_outlined),
                title: Text('Help & Support'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
