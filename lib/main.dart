import 'package:flutter/material.dart';
import 'package:rain_bloc/BLoCs/BlocContainer.dart';
import 'package:rain_bloc/BLoCs/LocationBloc/LocationBloc.dart';
import 'package:rain_bloc/DataSources/LocationDSModel.dart';
// import 'package:rain_bloc/UiViews/HomeView.dart';
import 'package:rain_bloc/UiViews/RestaurantView.dart';

import 'UiViews/HomePage.dart';

void main() { runApp(MainApp()); }

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocContainer<LocationBloc>(
        bloc: LocationBloc(),
        child: MaterialApp(
          title: 'Hello Bloc App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainScreen(),
        ));
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: BlocContainer.of<LocationBloc>(context).stream,
      builder: (context, snapshot) {
        final LocationDSModel location = snapshot.data;

        if (location == null) {
          return HomePage();
        }
        
        print(location.title);
         return RestaurantView(location: location);
      }
    );
  }
}

