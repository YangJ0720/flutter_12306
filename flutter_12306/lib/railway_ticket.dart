import 'package:flutter/material.dart';
import 'package:flutter_12306/bean/ticket.dart';
import 'package:flutter_12306/network/dio_manager.dart';

class RailwayTicket extends StatefulWidget {
  /// 起点站
  final String stationFrom;

  /// 终点站
  final String stationTo;

  /// 乘车日期
  final String dateTime;

  RailwayTicket(this.stationFrom, this.stationTo, this.dateTime);

  @override
  State<StatefulWidget> createState() {
    return RailwayTicketState();
  }
}

class RailwayTicketState extends State<RailwayTicket> {
  final List<Ticket> list = List<Ticket>();

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  /// 根据起点站、终点站查询高铁列表
  void _requestData() async {
    print('stationFrom = ${widget.stationFrom}');
    print('stationTo = ${widget.stationTo}');
    print('dateTime = ${widget.dateTime}');
    List<Ticket> result = await DioManager.getTickets(
        widget.stationFrom, widget.stationTo, widget.dateTime);
    if (result != null && result.isNotEmpty) {
      setState(() {
        list.addAll(result);
      });
    }
  }

  /// 下拉刷新
  Future<List<Ticket>> _onRefresh() async {
    List<Ticket> result = await DioManager.getTickets(
        widget.stationFrom, widget.stationTo, widget.dateTime);
    setState(() {
      list.clear();
      if (result.isNotEmpty) {
        list.addAll(result);
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '车票查询',
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('车票查询'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemCount: list == null ? 0 : list.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text('${list[index].timeFrom}'),
                                Text('${list[index].stationFrom}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${list[index].duration}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text('${list[index].trainNumber}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text('${list[index].timeTo}'),
                                Text('${list[index].stationTo}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '¥79.5',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    list[index].twoLevel,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  list[index].oneLevel,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '无座:${list[index].noLevel}张',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(''),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
