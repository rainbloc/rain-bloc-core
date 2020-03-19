import 'package:hello_bloc/DataSources/LocationDSModel.dart';
import 'package:hello_bloc/DataSources/REST/Zomato/DSRestZomatoClient.dart';
import '../Bloc.dart';

// business Logic Component for Location

class LocationBloc extends BlocMaster{
  LocationDSModel _location;
  LocationDSModel get selectedLocation => _location;
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
    this.blocController.sink.add(location);
  }

  void findLocation(String query) async {
    // 1
    print("find location");
    final results = await _client.fetchLocations(query);
    this.blocController.sink.add(results);
  }
}