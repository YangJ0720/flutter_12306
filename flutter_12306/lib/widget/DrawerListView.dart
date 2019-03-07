import 'package:flutter/material.dart';

class DrawerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('images/t3.jpg'),
          ),
          accountName: Text('YangJ0720'),
          accountEmail: Text('YangJ0720@gmail.com'),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '历史记录',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '注销登录',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
