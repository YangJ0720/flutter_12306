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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('12306Plus'),
        bottom: TabBar(
          key: PageStorageKey(2),
          controller: _tabController,
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
      body: TabBarView(
        key: PageStorageKey(2),
        children: <Widget>[
          TabOne(),
          TabTwo(),
        ],
        controller: _tabController,
      ),
    );
  }
}
