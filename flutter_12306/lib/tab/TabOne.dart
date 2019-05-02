import 'package:flutter/material.dart';
import 'package:flutter_12306/bean/station.dart';
import 'package:flutter_12306/delegate/search_station_delegate.dart';
import 'package:flutter_12306/network/dio_manager.dart';
import 'package:flutter_12306/railway_ticket.dart';
import 'package:flutter_12306/utils/DateUtils.dart';

/// 选项卡：查询
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

class TabOneHomePageState extends State<TabOneHomePage>
    with AutomaticKeepAliveClientMixin {
  Station stationFrom;
  Station stationTo;
  DateTime dateTime;
  bool isFast;
  bool isStudent;

  TabOneHomePageState() {
    // 默认起点站
    this.stationFrom = Station('IOQ', '深圳北');
    // 默认终点站
    this.stationTo = Station('IZQ', '广州南');
    // 默认日期
    this.dateTime = DateTime.now();
    // 高铁动车
    this.isFast = false;
    // 学生票
    this.isStudent = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          LocationStationWidget(
            valueChanged: (list) {
              setState(() {
                stationFrom = list[0];
                stationTo = list[1];
              });
            },
            stationFrom: stationFrom,
            stationTo: stationTo,
          ),
          DateTimeWidget(
              valueChanged: (value) {
                setState(() {
                  dateTime = value;
                });
              },
              dateTime: dateTime),
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
                    Checkbox(
                      value: isFast,
                      onChanged: (bool value) {
                        setState(() {
                          isFast = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '学生票',
                      style: TextStyle(fontSize: 14),
                    ),
                    Checkbox(
                      value: isStudent,
                      onChanged: (bool value) {
                        setState(() {
                          isStudent = value;
                        });
                      },
                    ),
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

  @override
  bool get wantKeepAlive => true;
}

/// 起点站和终点站
class LocationStationWidget extends StatefulWidget {
  final ValueChanged<List<Station>> valueChanged;
  Station stationFrom;
  Station stationTo;

  LocationStationWidget({this.valueChanged, this.stationFrom, this.stationTo});

  @override
  LocationStationWidgetState createState() => LocationStationWidgetState();
}

class LocationStationWidgetState extends State<LocationStationWidget>
    with AutomaticKeepAliveClientMixin {
  List<Station> stations;

  LocationStationWidgetState() {
    requestStations();
  }

  /// 获取站点信息
  void requestStations() async {
    stations = await DioManager.getStations();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('站点数据加载完毕')));
  }

  /// 更换起点站和终点站
  void _exchangeLocation() {
    setState(() {
      final Station temp = widget.stationFrom;
      widget.stationFrom = widget.stationTo;
      widget.stationTo = temp;
      // 回调到父Widget
      List<Station> list = [widget.stationFrom, widget.stationTo];
      widget.valueChanged(list);
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
              '${widget.stationFrom.name}',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              final Station station = await showSearch(
                  context: context, delegate: SearchStationDelegate(stations));
              if (station == null) {
                return;
              }
              setState(() {
                widget.stationFrom = station;
                print(
                    'station.code = ${station.code}, station.name = ${station.name}');
                // 回调到父Widget
                List<Station> list = [widget.stationFrom, widget.stationTo];
                widget.valueChanged(list);
              });
            }),
        IconButton(
            icon: Icon(Icons.repeat),
            onPressed: () {
              _exchangeLocation();
            }),
        MaterialButton(
            child: Text(
              '${widget.stationTo.name}',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              final Station station = await showSearch(
                  context: context, delegate: SearchStationDelegate(stations));
              setState(() {
                widget.stationTo = station;
                print(
                    'station.code = ${station.code}, station.name = ${station.name}');
                // 回调到父Widget
                List<Station> list = [widget.stationFrom, widget.stationTo];
                widget.valueChanged(list);
              });
            })
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 乘车日期
class DateTimeWidget extends StatefulWidget {
  ValueChanged<DateTime> valueChanged;
  DateTime dateTime;

  DateTimeWidget({this.valueChanged, this.dateTime});

  @override
  DateTimeWidgetState createState() => DateTimeWidgetState();
}

class DateTimeWidgetState extends State<DateTimeWidget>
    with AutomaticKeepAliveClientMixin {
  void _selectDate(BuildContext context) {
    var _dateTime = DateTime.now();
    var _firstDate = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
    var _lastDate =
        DateTime(_firstDate.year, _firstDate.month + 1, _firstDate.day);
    showDatePicker(
            context: context,
            initialDate: _firstDate,
            firstDate: _firstDate,
            lastDate: _lastDate)
        .then<DateTime>((DateTime value) {
      setState(() {
        // 如果用户点击cancel会返回null
        if (value == null) {
          return;
        }
        widget.dateTime = value;
        widget.valueChanged(value);
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
                '${DateUtils.getDateMMDDByDate(widget.dateTime)}',
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

  @override
  bool get wantKeepAlive => true;
}
