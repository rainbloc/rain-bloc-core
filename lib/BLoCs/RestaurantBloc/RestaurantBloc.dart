import 'dart:async';

import 'package:rain_bloc/BLoCs/Bloc.dart';
import 'package:rain_bloc/DataSources/LocationDSModel.dart';
import 'package:rain_bloc/DataSources/REST/Zomato/DSRestZomatoClient.dart';
import 'package:rain_bloc/DataSources/RestaurantDSModel.dart';

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