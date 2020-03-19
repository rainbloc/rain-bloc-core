class LocationDSModel {
  final int id;
  final String type;
  final String title;
  final String cityName;

  LocationDSModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['entity_id'],
        type = json['entity_type'],
        title = json['title'],
        cityName = json['city_name'];
}
