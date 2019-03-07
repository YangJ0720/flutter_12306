import 'package:flutter/material.dart';
import 'package:flutter_12306/tab/TabOne.dart';
import 'package:flutter_12306/tab/TabTwo.dart';
import 'package:flutter_12306/widget/DrawerListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('12306Plus'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: '查询',
                  ),
                  Tab(
                    text: '抢票',
                  ),
                ],
              ),
            ),
            drawer: Drawer(child: DrawerListView()),
            body: TabBarView(children: <Widget>[
              TabOne(),
              TabTwo(),
            ]),
          )),
    );
  }
}
