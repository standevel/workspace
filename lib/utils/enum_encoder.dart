import 'dart:convert';

import '../enums/event_type.enum.dart';

class EventTypeEncoder extends Converter<EventType, String> {
  const EventTypeEncoder();

  @override
  String convert(EventType input) => input.toString().split('.').last;
}
