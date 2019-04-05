class Ticket {
  String trainNumber;

  /// 起点站
  String stationFrom;

  /// 终点站
  String stationTo;

  /// 发车时间
  String timeFrom;

  /// 达到时间
  String timeTo;

  /// 时长
  String duration;

  /// 特等座
  String superLevel;

  /// 一等座
  String _oneLevel;

  /// 二等座
  String _twoLevel;

  /// 无座
  String noLevel;

  Ticket(this.trainNumber, this.stationFrom, this.stationTo, this.timeFrom,
      this.timeTo, this.duration);

  String get oneLevel {
    if ('有' == _oneLevel) {
      return '一等座:有';
    } else if ('无' == _oneLevel) {
      return '一等座:$_oneLevel';
    }
    return '一等座:$_oneLevel张';
  }

  set oneLevel(String value) {
    _oneLevel = value;
  }

  get twoLevel {
    if ('有' == _twoLevel) {
      return '二等座:有';
    } else if ('无' == _twoLevel) {
      return '二等座:$_twoLevel';
    }
    return '二等座:$_twoLevel张';
  }

  set twoLevel(String value) {
    _twoLevel = value;
  }

  @override
  String toString() {
    return 'Ticket{trainNumber: $trainNumber, stationFrom: $stationFrom, stationTo: $stationTo, timeFrom: $timeFrom, timeTo: $timeTo, duration: $duration, superLevel: $superLevel, oneLevel: $oneLevel, _twoLevel: $_twoLevel, noLevel: $noLevel}';
  }
}
