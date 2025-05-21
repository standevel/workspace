import 'channel.dart';
import 'user.dart';

class Message {
  String content;
  User? receiver;
  Channel? channel;
  User sender;
  List<MessageFile>? files;
  List<MessageReaction>? reactions;
  List<String>? mentions;
  List<String>? readBy;
  bool isPrivate;
  DateTime? updatedAt;
  DateTime? createdAt;

  Message({
    required this.content,
    required this.receiver,
    required this.channel,
    required this.sender,
    required this.files,
    required this.reactions,
    required this.mentions,
    required this.readBy,
    this.createdAt,
    this.updatedAt,
    required this.isPrivate,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    print('message json: $json');
    return Message(
        content: json['content'],
        receiver:
            json['receiver'] != null ? User.fromJson(json['receiver']) : null,
        channel:
            json['channel'] != null ? Channel.fromJson(json['channel']) : null,
        sender: User.fromJson(json['sender']),
        files: json['files'] != null
            ? List<MessageFile>.from(
                json['files'].map((file) => MessageFile.fromJson(file)))
            : null,
        reactions: json['reactions'] != null
            ? List<MessageReaction>.from(json['reactions']
                .map((reaction) => MessageReaction.fromJson(reaction)))
            : null,
        mentions: json['mentions'] != null
            ? List<String>.from(json['mentions'])
            : null,
        readBy:
            json['readBy'] != null ? List<String>.from(json['readBy']) : null,
        isPrivate: json['isPrivate'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null, // Convert string to DateTime
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null // Convert string to DateTime
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'receiver': receiver?.toJson(),
      'channel': channel?.toJson(),
      'sender': sender.toJson(),
      'files': files?.map((file) => file.toJson()).toList(),
      'reactions': reactions?.map((reaction) => reaction.toJson()).toList(),
      'mentions': mentions,
      'readBy': readBy,
      'isPrivate': isPrivate,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String()
    };
  }
}

class MessageFile {
  String fileName;
  String type;
  int size;
  String url;

  MessageFile({
    required this.fileName,
    required this.type,
    required this.size,
    required this.url,
  });

  factory MessageFile.fromJson(Map<String, dynamic> json) {
    return MessageFile(
      fileName: json['fileName'],
      type: json['type'],
      size: json['size'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'type': type,
      'size': size,
      'url': url,
    };
  }
}

class MessageReaction {
  String reaction;
  String userId;
  String username;
  DateTime timestamp;

  MessageReaction({
    required this.reaction,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  factory MessageReaction.fromJson(Map<String, dynamic> json) {
    return MessageReaction(
      reaction: json['reaction'],
      userId: json['userId'],
      username: json['username'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reaction': reaction,
      'userId': userId,
      'username': username,
      'timestamp': timestamp,
    };
  }
}
