import 'package:flutter/material.dart';
import 'package:flutter_12306/bean/ticket.dart';
import 'package:flutter_12306/network/dio_manager.dart';

class RailwayTicket extends StatefulWidget {
  final String locationS;
  final String locationE;
  final String dateTime;

  RailwayTicket(this.locationS, this.locationE, this.dateTime);

  @override
  State<StatefulWidget> createState() {
    return RailwayTicketState(locationS, locationE, dateTime);
  }
}

class RailwayTicketState extends State<RailwayTicket> {
  final String stationFrom;
  final String stationTo;
  final String dateTime;
  final List<Ticket> list = List<Ticket>();

  RailwayTicketState(this.stationFrom, this.stationTo, this.dateTime);

  void _requestData() async {
    print('stationFrom = $stationFrom');
    print('stationTo = $stationTo');
    print('dateTime = $dateTime');
    List<Ticket> result =
        await DioManager.getTickets(stationFrom, stationTo, dateTime);
    if (result != null && result.isNotEmpty) {
      setState(() {
        list.addAll(result);
      });
    }
  }

  Future<List<Ticket>> _onRefresh() async {
    List<Ticket> result =
        await DioManager.getTickets(stationFrom, stationTo, dateTime);
    if (result.isNotEmpty) {
      list.clear();
      list.addAll(result);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    _requestData();
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
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('${list[index].timeFrom}'),
                                Text('${list[index].stationFrom}'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('${list[index].trainNumber}'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('${list[index].timeTo}'),
                                Text('${list[index].stationTo}'),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('二等座:0张'),
                            Text('一等座:0张'),
                            Text('无座:0张'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
