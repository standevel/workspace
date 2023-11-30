import 'package:peersync/enums/event_type.enum.dart';

class EventPayload {
  final EventType type;
  final dynamic data;
  EventPayload({required this.type, this.data});

  Map<String, dynamic> toJson() {
    return {'type': type.name.toString(), 'data': data};
  }

  factory EventPayload.fromJson(Map<String, dynamic> json) {
    return EventPayload(type: json['type'], data: json['data']);
  }
}
