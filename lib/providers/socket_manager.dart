import 'package:peersync/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket _socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    // Initialize your Socket.IO connection here
    _socket = IO.io(chatUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Handle socket events or configurations if needed
    _socket.onConnect((_) => print('Connected'));
    _socket.onDisconnect((_) => print('Disconnected'));

    // You can add more event handlers or configurations as needed
  }

  IO.Socket get socket => _socket;

  void connect() {
    _socket.connect();
  }

  void disconnect() {
    _socket.disconnect();
  }
}
