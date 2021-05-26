import 'package:flutter/material.dart';
import 'package:green_plant/core/database/Helper.dart';
import 'package:green_plant/models/notification_model.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<NotificationModel> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return createListView(context, snapshot);
            }),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    userList = snapshot.data;
    if (userList != null) {
      return new ListView.builder(
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          print(userList[index].id);
          return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                DatabaseHelper.db.deleteUser(userList[index].id);
              },
              child: _buildItem(userList[index], index));
        },
      );
    } else
      return Container();
  }

  Future<List<NotificationModel>> _getData() async {
    var dbHelper = DatabaseHelper.db;
    await dbHelper.getAllUsers().then((value) {
      userList = value;
    });

    return userList;
  }

  ///Construct cell for List View
  Widget _buildItem(NotificationModel values, int index) {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown,
                    child: Image.network(values.image),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0)),
                new Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                    new InkWell(
                      child: Container(
                        constraints: new BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 200),
                        child: Text(
                          values.name,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
                new Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                    new InkWell(
                      child: new Text(
                        values.body.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
              ],
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              DatabaseHelper.db.deleteUser(userList[index].id);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
