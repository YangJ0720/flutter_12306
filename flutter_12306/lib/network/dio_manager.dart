import 'package:dio/dio.dart';
import 'package:flutter_12306/bean/station.dart';
import 'package:flutter_12306/bean/ticket.dart';
import 'package:flutter_12306/config/constants.dart';
import 'package:flutter_12306/utils/map_utils.dart';

class DioManager {
  /// 获取站点信息
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
  static Future<List<Ticket>> getTickets(String from, String to, String date) async {
    var path =
        '${Constants.host}otn/leftTicket/queryZ?leftTicketDTO.train_date=$date&leftTicketDTO.from_station=$from&leftTicketDTO.to_station=$to&purpose_codes=ADULT';
    Response response = await Dio().get(path);
    print('response = $response');
    List<Ticket> tickets = List<Ticket>();
    if (response != null) {
      Map data = response.data['data'];
      Map map = data['map'];
      print('data.map = $map');
      List result = data['result'];
      print('data.result = $result}');
      result.forEach((it) {
        List<String> info = it.split('|');
        List<String> keys = [info[4], info[5], info[6], info[7]];
        String stationFrom = MapUtils.getValueByMap(map, keys);
        String stationTo = MapUtils.getValueByMap(map, keys);
        tickets.add(Ticket(info[3], stationFrom, stationTo, info[8], info[9]));
      });
      print('tickets = $tickets');
    }
    return tickets;
  }
}
