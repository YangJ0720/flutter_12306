import 'package:dio/dio.dart';
import 'package:flutter_12306/bean/station.dart';
import 'package:flutter_12306/bean/ticket.dart';
import 'package:flutter_12306/config/constants.dart';
import 'package:flutter_12306/utils/map_utils.dart';

class DioManager {
  /// 获取全国所有高铁站点信息
  static Future<List<Station>> getStations() async {
    var path =
        '${Constants.host}otn/resources/js/framework/station_name.js?station_version=1.9001';
    Response response = await Dio().get(path);
    if (response != null) {
      String data = response.data;
      int index = data.indexOf('\'');
      int lastIndex = data.lastIndexOf('\'');
      List<String> list = data.substring(index + 1, lastIndex - 1).split('@');
      if (list.isNotEmpty) {
        List<Station> stations = [];
        list.forEach((s) {
          List<String> info = s.split('|');
          print('info = $info');
          if (info.length >= 3) {
            Station station = Station(info[2], info[1]);
            stations.add(station);
          }
        });
        return stations;
      }
    }
    return null;
  }

  /// 根据起点、终点、日期获取车票信息
  static Future<List<Ticket>> getTickets(
      String from, String to, String date) async {
    var path =
        '${Constants.host}otn/leftTicket/query?leftTicketDTO.train_date=$date&leftTicketDTO.from_station=$from&leftTicketDTO.to_station=$to&purpose_codes=ADULT';

    /// 12306地址变化规律，真的是在卖票的路上越走越远
    // otn/leftTicket/query
    // otn/leftTicket/queryX
    // otn/leftTicket/queryY
    // otn/leftTicket/queryZ
    print('path = $path');
    Response response = await Dio().get(path);
    print('response = $response');
    print('response.statusCode = ${response.statusCode}');
    print('response.data = ${response.data}');
    List<Ticket> tickets = List<Ticket>();
    if (response != null) {
      Map data = response.data['data'];
      Map map = data['map'];
      print('data.map = $map');
      List result = data['result'];
      print('data.result = $result}');
      result.forEach((it) {
        List<String> info = it.split('|');
        print('item = $it');
        // 解析站点编号，示例：|SZQ|LYF|SZQ|GZQ|
        List<String> keys = [info[4], info[5], info[6], info[7]];
        // 根据站点编号转换为对应的站点名称
        List<String> values = MapUtils.getStationByMap(map, keys);
        String stationFrom = values[0];
        String stationTo = values[1];
        // 初始化Ticket
        var ticket =
            Ticket(info[3], stationFrom, stationTo, info[8], info[9], info[10]);
        ticket.superLevel = info[33];
        ticket.oneLevel = info[32];
        ticket.twoLevel = info[31];
        ticket.noLevel = info[21];
        tickets.add(ticket);
        print('ticket = $ticket');
      });
    }
    return tickets;
  }
}
