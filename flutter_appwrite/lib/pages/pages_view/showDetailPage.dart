import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_one/data/model/addData_model.dart';
import 'package:easy_one/data/model/user_model.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/pages/pages_view/homePage.dart';
import 'package:easy_one/widget/elevatedButton_widget.dart';
import 'package:easy_one/widget/makeText.dart';
import 'package:easy_one/widget/routeHelper.dart';
import 'package:easy_one/widget/textFormField_widget.dart';

class ShowDetailPage extends StatefulWidget {
  final AddData addData;
  final User user;
  ShowDetailPage({this.addData, this.user});

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  TextEditingController _edittitle;
  TextEditingController _editdescription;

  List<AddData> gettingData = [];
  bool loading = true;
  bool isEdit;

  @override
  void initState() {
    super.initState();
    _getDataInsert();
    isEdit = widget.addData != null;

    _edittitle =
        TextEditingController(text: isEdit ? widget.addData.title : '');
    _editdescription =
        TextEditingController(text: isEdit ? widget.addData.description : '');
  }

  void _getDataInsert() async {
    gettingData = await ApiService.instance.insertData();
    loading = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: makeText(
          widget.user.name,
          color: Colors.black,
        ),
      ),
      body: loading == null
          ? ''
          : Stack(
              children: [
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        widget.addData.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        widget.addData.description,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      makeText(
                          DateFormat.yMMMEd().format(
                            widget.addData.date,
                          ),
                          color: Colors.grey),
                    ],
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      try {
                        await ApiService.instance
                            .deleteData(documentId: widget.addData.id);
                        _getDataInsert();

                        pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Delete Successfully'),
                          ),
                        );
                      } on AppwriteException catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 70,
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.indigo,
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return SimpleDialog(
                                contentPadding: EdgeInsets.all(10),
                                children: [
                                  textFormField(
                                    hintText: "title",
                                    controller: _edittitle,
                                    textColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  textFormField(
                                    hintText: "description",
                                    controller: _editdescription,
                                    textColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  elevatedButton(
                                    context,
                                    "Update",
                                    onPressed: () async {
                                      final checkData = AddData(
                                        title: _edittitle.text,
                                        description: _editdescription.text,
                                        date: DateTime.now().add(
                                          Duration(
                                            days: Random().nextInt(5),
                                          ),
                                        ),
                                      );
                                      try {
                                        var added =
                                            await ApiService.instance.editData(
                                          addData: checkData,
                                          documentId: widget.addData.id,
                                        );
                                        print(added);
                                        _getDataInsert();
                                        _editdescription.clear();
                                        _edittitle.clear();
                                        push(
                                          context,
                                          HomePage(
                                            user: widget.user,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Edit Successfully'),
                                          ),
                                        );
                                      } on AppwriteException catch (e) {
                                        print(e.message);
                                      }
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
    ));
  }
}
