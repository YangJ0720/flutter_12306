import 'package:flutter/material.dart';
import 'package:flutter_12306/bean/station.dart';
import 'package:flutter_12306/delegate/search_station_delegate.dart';
import 'package:flutter_12306/network/dio_manager.dart';
import 'package:flutter_12306/railway_ticket.dart';
import 'package:flutter_12306/utils/DateUtils.dart';

class TabOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabOneHomePage();
  }
}

class TabOneHomePage extends StatefulWidget {
  @override
  TabOneHomePageState createState() {
    return TabOneHomePageState();
  }
}

class TabOneHomePageState extends State<TabOneHomePage> {
  Station stationFrom;
  Station stationTo;
  DateTime dateTime;


  TabOneHomePageState() {
    this.stationFrom = Station('IOQ', '深圳北');
    this.stationTo = Station('IZQ', '广州南');
    this.dateTime = DateTime.now();

    print('TabOneHomePageState -> stationFrom = ${stationFrom.name}');
    print('TabOneHomePageState -> stationTo = ${stationTo.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          LocationStationWidget(stationFrom, stationTo),
          DateTimeWidget(dateTime),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '高铁动车',
                      style: TextStyle(fontSize: 14),
                    ),
                    Checkbox(value: false, onChanged: (bool value) {}),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '学生票',
                      style: TextStyle(fontSize: 14),
                    ),
                    Checkbox(value: false, onChanged: (bool value) {}),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text(
                    '查询',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    print('stationFrom = ${stationFrom.name}');
                    print('stationTo = ${stationTo.name}');
                    print('dateTime = $dateTime');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RailwayTicket(
                                stationFrom.code,
                                stationTo.code,
                                DateUtils.getDateYYYYMMDDByDate(dateTime))));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

/// 起点站和终点站
class LocationStationWidget extends StatefulWidget {
  final Station stationFrom;
  final Station stationTo;

  LocationStationWidget(this.stationFrom, this.stationTo);

  @override
  LocationStationWidgetState createState() =>
      LocationStationWidgetState(stationFrom, stationTo);
}

class LocationStationWidgetState extends State<LocationStationWidget> {
  List<Station> stations;
  Station stationFrom;
  Station stationTo;

  LocationStationWidgetState(this.stationFrom, this.stationTo) {
    requestStations();
  }

  /// 获取站点信息
  void requestStations() async {
    stations = await DioManager.getStations();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('站点数据加载完毕')));
  }

  void _exchangeLocation() {
    setState(() {
      final Station temp = stationFrom;
      stationFrom = stationTo;
      stationTo = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
            child: Text(
              '${stationFrom.name}',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              final Station station = await showSearch(
                  context: context, delegate: SearchStationDelegate(stations));
              if (station == null) {
                return;
              }
              setState(() {
                stationFrom = station;
                print('stationFrom = ${stationFrom.name}');
              });
            }),
        IconButton(
            icon: Icon(Icons.cached),
            onPressed: () {
              _exchangeLocation();
            }),
        MaterialButton(
            child: Text(
              '${stationTo.name}',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              final Station station = await showSearch(
                  context: context, delegate: SearchStationDelegate(stations));
              setState(() {
                stationTo = station;
              });
            })
      ],
    );
  }
}

/// 乘车日期
class DateTimeWidget extends StatefulWidget {
  final DateTime dateTime;

  DateTimeWidget(this.dateTime);

  @override
  DateTimeWidgetState createState() => DateTimeWidgetState(dateTime);
}

class DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime dateTime;

  DateTimeWidgetState(this.dateTime);

  void _selectDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2020))
        .then<DateTime>((DateTime value) {
      setState(() {
        dateTime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              child: Text(
                '${DateUtils.getDateMMDDByDate(dateTime)}',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey, width: 0.5, style: BorderStyle.solid))),
    );
  }
}
