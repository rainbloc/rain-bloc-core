import 'package:flutter/material.dart';
import 'package:rain_bloc/Cores/ViewComponents/CustomFontIcon.dart';
import 'package:rain_bloc/Cores/ViewComponents/customIcon.dart';
import 'package:rain_bloc/Cores/publicFunctions.dart';
import 'package:url_launcher/url_launcher.dart';

Widget homePageLoadFeed(BuildContext context, {Map data}) {
  List<dynamic> articles = data["articles"];
  int articlesLength = articles == null ? 0 : articles.length;

  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: articlesLength + 1,
    itemBuilder: (BuildContext context, int index) {
      // if(articles.indexOf(index) == -1){
      //   return SizedBox(height:100);
      // }
      dynamic articleItem;
      try {
        articleItem = articles[index];
      } catch (e) {
       return SizedBox(height:20);
      }

      return GestureDetector(
          onTap: () async {
            String url = articleItem["url"];
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              color: Colors.black.withOpacity(0.2),
            ),
            padding: EdgeInsets.only(
                bottom: 25.0, top: 15.0, left: 15.0, right: 15.0),
            child: Column(children: <Widget>[
              Container(
                height: 240,
                decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(articleItem["urlToImage"]),
                        fit: BoxFit.cover)),
              ),
              SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(formatDate(articleItem["publishedAt"]),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFFf1c40f),
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          letterSpacing: 0.5))),
              SizedBox(height: 10),
              Text(articleItem["title"],
                  style: TextStyle(
                      color: Color(0xFFFFEEEE),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      letterSpacing: 0.5)),
              SizedBox(height: 10),
              Text(articleItem["description"] + '...',
                  style: TextStyle(
                      color: Color(0xFFCCCCCC),
                      letterSpacing: 0.3,
                      fontSize: 11))
            ]),
          ));
    },
    separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(height: 10),
  );
}

Widget homePageListOfButtons({double btnWidth}) {
  return Row(children: <Widget>[
    SizedBox(
      width: btnWidth,
      child: FlatButton(
        color: Colors.transparent,
        textColor: Color(0xFFE3E3E3),
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Color(0xFFE3E3E3), width: 2.0)),
        child: Text(
          "Lihat Laporan",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        /* Flat Button On Press*/
        onPressed: () {
          print("Page pressed");
          //goToPage('/laporan-page');
        },
      ),
    ),
    SizedBox(width: 20.0),
    SizedBox(
      width: btnWidth,
      child: RaisedButton(
        color: Color(0xFFF3F3F3),
        textColor: Color(0xFF27ae60),
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.transparent, width: 2.0)),
        child: Text(
          "Sedekah",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        /* Flat Button On Press*/
        onPressed: () {
          print("Page pressed 2");
        },
      ),
    ),
  ]);
}

List<dynamic> homePageIconList = [
  customIcon(CustomFontIcon.islam, text: "Cari\nMasjid"),
  customIcon(CustomFontIcon.newspaper, text: "Portal\nBerita"),
  customIcon(CustomFontIcon.quran_rehal, text: "Quran & Sunnah"),
  customIcon(Icons.favorite_border, text: "Berita\nfavorit"),
  customIcon(Icons.event, text: "Acara\npenting"),
  customIcon(Icons.build, text: "Konfigurasi\nSaya"),
];
