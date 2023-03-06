import 'dart:math';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:easy_one/data/model/addData_model.dart';
import 'package:easy_one/data/model/user_model.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/main.dart';
import 'package:easy_one/pages/pages_view/showDetailPage.dart';
import 'package:easy_one/widget/elevatedButton_widget.dart';
import 'package:easy_one/widget/makeText.dart';
import 'package:easy_one/widget/routeHelper.dart';
import 'package:easy_one/widget/textFormField_widget.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  User user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _title;
  TextEditingController _description;

  List<AddData> gettingData = [];

  void _getDataInsert() async {
    gettingData = await ApiService.instance.insertData();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataInsert();
    _title = TextEditingController();
    _description = TextEditingController();
    _getUser();
  }

  _getUser() async {
    try {
      widget.user = await ApiService.instance.getUser();
      setState(() {});
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          _bottomSheet(size, context);
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            if (widget.user != null) ...[
              Stack(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(widget.user.name),
                    accountEmail: Text(widget.user.email),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade500,
                    ),
                    currentAccountPicture: widget.user.prefs['photo'] != null
                        ? FutureBuilder(
                            future: ApiService.instance.getProfile(
                              widget.user.prefs['photo'],
                            ),
                            builder: (_, snapshot) {
                              return CircleAvatar(
                                backgroundImage: snapshot.data != null
                                    ? MemoryImage(snapshot.data as Uint8List)
                                    : NetworkImage(
                                        "https://images.unsplash.com/photo-1622902321346-a647b68e95f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=386&q=80",
                                      ),
                              );
                            },
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1622902321346-a647b68e95f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=386&q=80",
                            ),
                          ),
                  ),
                  Positioned(
                      left: size.width * 0.2,
                      top: size.height * 0.05,
                      child: IconButton(
                        tooltip: "Change Image",
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _upload,
                      )),
                ],
              ),
            ],
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                try {
                  await ApiService.instance.logout();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Logout'),
                  ));
                  pushReplacement(context, MainPage());
                } on AppwriteException catch (e) {
                  print(e.message);
                }
              },
            ),
          ],
        ),
      ),
      appBar: appbar(),
      body: StaggeredGridView.countBuilder(
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(1, index.isEven ? 0.5 : 0.7),
        physics: BouncingScrollPhysics(),
        itemCount: gettingData.length,
        crossAxisCount: 2,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () async {
              await push(
                context,
                ShowDetailPage(
                  addData: gettingData[index],
                  user: widget.user,
                ),
              );
              _getDataInsert();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  top: size.height * 0.02,
                  right: size.width * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    makeText(
                      gettingData[index].title,
                      fontWeight: FontWeight.bold,
                    ),
                    makeText(gettingData[index].description,
                        color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget appbar() {
    return AppBar(
      title: Text("Easyone"),
      backgroundColor: Colors.indigo.shade500,
    );
  }

  void _bottomSheet(size, BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.03,
            ),
            child: Container(
              height: size.height * 0.32,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: makeText(
                      "Add Data",
                      fontWeight: FontWeight.bold,
                      size: 19,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  textFormField(
                    hintText: 'title',
                    controller: _title,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  textFormField(
                    hintText: 'description',
                    controller: _description,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  elevatedButton(
                    context,
                    'Add',
                    size: Size(size.width * 0.4, 50),
                    onPressed: () async {
                      final checkData = AddData(
                        title: _title.text,
                        description: _description.text,
                        date: DateTime.now().add(
                          Duration(
                            days: Random().nextInt(5),
                          ),
                        ),
                      );
                      _title.clear();
                      _description.clear();
                      try {
                        var added = await ApiService.instance.getAddData(
                          addData: checkData,
                          permissions: [
                            Permission.update(Role.user(widget.user.id)),
                            Permission.delete(Role.user(widget.user.id))
                          ],
                        );
                        print(added);
                        _getDataInsert();
                        pop(context);
                      } on AppwriteException catch (e) {
                        print(e.message);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _upload() async {
    var image = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    final file = InputFile(path: image.path);
    try {
      final res = await ApiService.instance.uploadPicture(
        file,
        ['user:${widget.user.id}'],
      );
      final id = res.$id;
      if (id != null) {
        await ApiService.instance.updatePrefs(
          {'photo': id},
        );
        _getUser();
      } else {
        print('something null');
      }
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }
}
