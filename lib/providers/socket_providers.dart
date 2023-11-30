import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/enums/event_type.enum.dart';
import 'package:peersync/model/event_payload.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/providers/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:riverpod/riverpod.dart';

import '../model/message.dart';

final StreamProvider<List<Message>> messagesProvider =
    StreamProvider<List<Message>>((ref) {
  Socket socket = SocketManager().socket;
  var activeChannel = ref.watch(activeChannelProvider);
  print('activeChannel in mesageProvider: ${activeChannel.name}');
  final controller = StreamController<List<Message>>();
  var requestChannelMessages = EventPayload(
      type: EventType.GET_CHANNEL_MESSAGES,
      data: {'channelId': activeChannel.id, 'page': 0, 'pageSize': 20});
  socket.emit(EVENT, requestChannelMessages);
  socket.on(EVENT, (payload) {
    if (EventType.GET_CHANNEL_MESSAGES.name
        .contains(payload['type'].toString())) {
      print('get channel messages: $payload');
      var messages = payload['data'] as List<dynamic>;
      controller.add(messages
          .map(
            (e) => Message.fromJson(e),
          )
          .toList());
    }
    if (EventType.NEW_MESSAGE.name.contains(payload['type'].toString())) {
      print('new message: $payload');
      var newMessage = payload['data'];
      var all = ref.state.value!;
      controller.add([...all, Message.fromJson(newMessage)]);
    }
  });

  ref.onDispose(() {
    // controller.close();
  });

  return controller.stream;
});
