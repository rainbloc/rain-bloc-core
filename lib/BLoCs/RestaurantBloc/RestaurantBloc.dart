import 'dart:async';

import 'package:rainbloc/BLoCs/Bloc.dart';
import 'package:rainbloc/DataSources/LocationDSModel.dart';
import 'package:rainbloc/DataSources/REST/Zomato/DSRestZomatoClient.dart';
import 'package:rainbloc/DataSources/RestaurantDSModel.dart';

class RestaurantBloc implements Bloc{

  RestaurantDSModel _retaurantDataSource;

  final LocationDSModel location;
  final _zomatoClient = DSRestZomatoClient();

  final _restaurantController = StreamController<List<RestaurantDSModel>>();
  Stream<List<RestaurantDSModel>> get stream => _restaurantController.stream;

  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final results = await _zomatoClient.fetchRestaurants(location, query);
    _restaurantController.sink.add(results);
  }

  @override
  void dispose() {
    _restaurantController.close();
  }
}