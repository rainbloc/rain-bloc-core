import 'package:rainbloc/DataSources/LocationDSModel.dart';
import 'package:rainbloc/DataSources/REST/Zomato/DSRestZomatoClient.dart';
import '../Bloc.dart';

// business Logic Component for Location

class LocationBloc extends BlocMaster{
  LocationDSModel _location;
  LocationDSModel get selectedLocation => _location;
  String _currentQuery;
  String get currentQuery => _currentQuery;
  final _client = DSRestZomatoClient();

  /* [3]
   * This function represents the input for 
   * the BLoC. A Location model object will 
   * be provided as parameter that is cached in 
   * the object’s private _location property and 
   * then added to sink for the stream.
   */ 
  void selectLocation(LocationDSModel location) {
    _location = location;
    this.sendStream(location);
  }

  void findLocation(String query) async {
    // 1
    _currentQuery = query;
    final results = await _client.fetchLocations(query);
    this.sendStream(results);
  }
}