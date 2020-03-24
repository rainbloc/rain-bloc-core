import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rainbloc/BLoCs/BlocContainer.dart';
import 'package:rainbloc/BLoCs/NewsBloc/NewsBloc.dart';
import 'package:rainbloc/Cores/Plugins/Multilanguages/BLoCs/MultiLangBloc/MultiLangBloc.dart';
import 'package:rainbloc/Cores/Plugins/Multilanguages/MultiLangs.dart';
import 'package:rainbloc/DataSources/SharedPref/SPMember.dart';

import 'HomepageComponents/HomepageFeed.dart';

class HomePage extends StatelessWidget {
  final bool isFullScreenDialog = false;
  static List<String> _imageUrls = [
    'https://i.postimg.cc/RV8XxDcS/img-surv.jpg',
    'https://i.postimg.cc/L8d3vpH5/img-surv-2.jpg',
    'https://i.postimg.cc/Jn58SqZT/img-surv-3.jpg',
    'https://i.postimg.cc/Njk4nC09/img-surv-4.jpg',
  ];

  static String _defaultLang = 'id';
  MultiLangs lgClass = new MultiLangs();
  final blocLang = MultiLangBloc();

  HomePage({Key key, bool isFullScreenDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocNews = NewsBloc();

    blocNews.getNews();
    blocLang.getLang();

    print("set default Lang ${lgClass.defaultLang}");
    //test Shared Preferences

    final icons = homePageIconList;
    final double btnWidth = (MediaQuery.of(context).size.width / 2) - 30;
    final Widget _buttons =
        homePageListOfButtons(btnWidth: btnWidth, parentObject: this);

    var rnd = new Random();
    var r = 0 + rnd.nextInt(_imageUrls.length - 0);

    //View based on Bloc Container
    return BlocContainer<NewsBloc>(
        bloc: blocNews,
        child: Scaffold(
          // appBar: AppBar(title: Text('Where do you want to eat?')),
          resizeToAvoidBottomPadding: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color(0xFF38EF7D),
                image: DecorationImage(
                    image: NetworkImage(_imageUrls[r]), fit: BoxFit.cover)),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [
                              0.15,
                              1
                            ],
                                colors: [
                              Color(0xFF11998E),
                              Color(0x00000000)
                            ])),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 250,
                            ),
                            Text(
                              lgClass.getLang(
                                  key: "current_fund_text",
                                  defaultText: "Hello World"),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(height: 20),
                            Text("2,578,001",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 52)),
                            SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: _buttons,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 240,
                                padding:
                                    new EdgeInsets.only(left: 20, right: 20),
                                child: Column(children: <Widget>[
                                  Expanded(
                                    child: GridView.builder(
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this would produce 2 rows.
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: 6,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      // Generate 100 Widgets that display their index in the List
                                      itemBuilder: (BuildContext context,
                                          int itemIndex) {
                                        return new GestureDetector(
                                            child: new Card(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              elevation: 0.0,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: icons[itemIndex]),
                                            ),
                                            onTap: () {
                                              lgClass.defaultLang = "en";
                                              print('tapped');
                                            });
                                      },
                                    ),
                                  )
                                ])),
                            Container(
                                height: 400,
                                // child: homePageLoadFeed(context))
                                child: _buildResults(blocNews)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildResults(NewsBloc blocNews) {
    return StreamBuilder<dynamic>(
      stream: blocNews.stream,
      builder: (context, streamResult) {
        final results = streamResult.data;
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
        return homePageLoadFeed(context, data: results);
      },
    );
  }
}
