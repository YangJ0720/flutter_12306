class Ticket {
  String trainNumber;
  String stationFrom;
  String stationTo;
  String timeFrom;
  String timeTo;

  Ticket(this.trainNumber, this.stationFrom, this.stationTo, this.timeFrom,
      this.timeTo);

  @override
  String toString() {
    return 'Ticket{trainNumber: $trainNumber, stationFrom: $stationFrom, stationTo: $stationTo, timeFrom: $timeFrom, timeTo: $timeTo}';
  }

}
