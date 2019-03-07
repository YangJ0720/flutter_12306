import 'package:flutter/material.dart';
import 'package:flutter_12306/bean/station.dart';

class SearchStationDelegate extends SearchDelegate<Station> {
  List<Station> stations;
  List<Station> defaultStations;

  SearchStationDelegate(List<Station> stations) {
    this.stations = stations;
    this.defaultStations = [
      Station('bjx', '北京西'),
      Station('shn', '上海南'),
      Station('gzn', '广州南'),
      Station('szb', '深圳北'),
    ];
  }

  List<Station> convertList() {
    if(stations == null) {
      stations = defaultStations;
    }
    final list = query.isEmpty
        ? defaultStations
        : stations.where((input) => input.name.startsWith(query)).toList();
    return list;
  }

  /// 右侧清除按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  /// 左侧返回按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  /// 输入法搜索按钮点击显示搜索内容
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  /// 输入搜索内容自动提示
  @override
  Widget buildSuggestions(BuildContext context) {
    final resultList = convertList();
    return ListView.builder(
      itemCount: resultList.length,
      itemBuilder: (context, index) => ListTile(
            title: RichText(
              text: TextSpan(
                  text: resultList[index].name.substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: resultList[index].name.substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
            onTap: () {
              close(context, resultList[index]);
            },
          ),
    );
  }
}
