import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket!;

  SocketService(){
    _initConfig();
  }

  void _initConfig() {
    _socket = IO.io('http://192.168.1.2:3001/',

    // IO.Socket socket = IO.io('https://flutter-bands-names.herokuapp.com/',
      IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .build()
    );
    _socket!.onConnect((_) {
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    
    _socket!.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', (payload) {
    //   print('Nuevo mensaje: $payload');
    // });

  }


}