import 'package:flutter/material.dart';
import 'package:hello_bloc/BLoCs/BlocContainer.dart';
import 'package:hello_bloc/BLoCs/LocationBloc/LocationBloc.dart';
import 'package:hello_bloc/DataSources/LocationDSModel.dart';
import 'package:hello_bloc/UiViews/HomeView.dart';
import 'package:hello_bloc/UiViews/RestaurantView.dart';

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
        print("location $location");
        print(location);

        if (location == null) {
          return HomeView();
        }
        
        print(location.title);
         return RestaurantView(location: location);
      }
    );
  }
}

