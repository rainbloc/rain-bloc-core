import 'package:flutter/material.dart';
import 'package:rain_bloc/BLoCs/BlocContainer.dart';
import 'package:rain_bloc/BLoCs/LocationBloc/LocationBloc.dart';
import 'package:rain_bloc/Cores/publicFunctions.dart';
import 'package:rain_bloc/DataSources/LocationDSModel.dart';
import 'package:rain_bloc/UiViews/RestaurantView.dart';

class HomeView extends StatelessWidget {
  final bool isFullScreenDialog;
  const HomeView({Key key, this.isFullScreenDialog = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationBloc();

    // 2
    return BlocContainer<LocationBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),

                // 3
                onChanged: (query) => bloc.findLocation(query),
              ),
            ),
            // 4
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationBloc bloc) {
    return StreamBuilder<dynamic>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        // 1
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Find a location'));
        }

        if (results.isEmpty) {
          return Center(
              child: Image(
            image: NetworkImage(
                'https://www.drcycle.in/assets/images/NoRecordFound.png'),
          ));
        }

        //if it has data show it here

        return _searchResultList(results);
      },
    );
  }

  Widget _searchResultList(List<LocationDSModel> results) {
    // 2
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            // final locationBloc = BlocContainer.of<LocationBloc>(context);
            // locationBloc.selectLocation(location);
            navigateTo(context, RestaurantView(location: location));
          },
        );
      },
    );
  }
}
