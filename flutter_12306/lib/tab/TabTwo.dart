import 'package:flutter/material.dart';

/// 选项卡：抢票
class TabTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TabTwoHomePage();
}

class TabTwoHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabTwoHomePageState();
}

class TabTwoHomePageState extends State<TabTwoHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('抢票'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
