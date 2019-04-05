class MapUtils {
  /// 根据站点编号获取站点名称
  static List<String> getStationByMap(
      Map<String, dynamic> map, List<String> list) {
    List<String> result = List<String>();
    int length = list.length;
    for (int i = 0; i < length; i++) {
      String key = list[i];
      if (map.containsKey(key)) {
        String value = map[key];
        if (result.isEmpty) {
          /// 起点站
          result.add(value);
        } else if (result.isNotEmpty && result[0] != value) {
          /// 终点站
          result.add(value);
          print('起点站:${result[0]}, 终点站:${result[1]}');
          return result;
        }
      }
    }
    return result;
  }
}
