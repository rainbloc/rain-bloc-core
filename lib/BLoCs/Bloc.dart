import 'dart:async';

abstract class Bloc {
  void dispose();
}

class BlocMaster implements Bloc{
 
  /*
   * [1]
   * Here a private StreamController is declared 
   * that will manage the stream and sink for 
   * this BLoC. StreamControllers use generics to 
   * tell the type system what kind of object 
   * will be emitted from the stream.
   */ 
   final blocController = StreamController<dynamic>();

/* [2] 
   * This line exposes a public getter to 
   * the StreamController’s stream.
   */ 
  Stream<dynamic> get stream => blocController.stream;

  @override
  void dispose() {
    blocController.close();
  }

  void sendStream(dynamic data){
    this.blocController.sink.add(data);
  }
}