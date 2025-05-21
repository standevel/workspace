import 'package:peersync/constants.dart';
import 'package:peersync/enums/event_type.enum.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../model/event_payload.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket _socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    _socket = IO.io(chatUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.onConnect((_) => print('Connected ${_socket.id}'));
    _socket.onDisconnect((_) => print('Disconnected'));
  }

  IO.Socket get socket => _socket;

  void connect(String userId) {
    // Connect to the socket with the provided user ID
    _socket.io.options!['query'] = {'userId': userId};
    _socket.connect();
  }

  emitMessage(EventPayload payload) {
    socket.emit(EVENT, payload.toJson());
  }

  emitMessageWithAsk(dynamic payload) {
    return socket.emitWithAck(EVENT, payload);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
