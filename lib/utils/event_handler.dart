import 'package:peersync/enums/event_type.enum.dart';

handleEvent(dynamic payload) {
  switch (payload['type']) {
    case EventType.JOIN_CHANNEL:
      handleJoinChannel(payload['data']);
      break;

    default:
  }
}

void handleJoinChannel(payload) {}
