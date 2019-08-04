import 'package:flutter/material.dart';

/// 选项卡：抢票
class TabTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabTwoHomePageState();
  }
}

class TabTwoHomePageState extends State<TabTwo>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('抢票'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
