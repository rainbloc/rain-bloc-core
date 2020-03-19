import 'package:flutter/material.dart';
import 'package:hello_bloc/BLoCs/BlocContainer.dart';
import 'package:hello_bloc/BLoCs/RestaurantBloc/RestaurantBloc.dart';
import 'package:hello_bloc/DataSources/LocationDSModel.dart';

class RestaurantView extends StatelessWidget{

  final LocationDSModel location;

  const RestaurantView({Key key, @required this.location}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: _buildSearch(context),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final bloc = RestaurantBloc(location);

    return BlocContainer<RestaurantBloc>(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(child:Text("hello hi " + location.title)),
          )
        ],
      ),
    );
  }

  
}