class MapUtils {
  /// 获取站点名称
  static String getValueByMap(Map<String, dynamic> map, List<String> list) {
    int length = list.length;
    for (int i = 0; i < length; i++) {
      String key = list[i];
      if (map.containsKey(key)) {
        var value = map[key];
        map.remove(key);
        return value;
      }
    }
    return null;
  }
}
