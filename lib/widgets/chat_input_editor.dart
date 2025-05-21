import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/constants.dart';
import 'package:peersync/enums/event_type.enum.dart';
import 'package:peersync/model/channel.dart';
import 'package:peersync/model/event_payload.dart';
import 'package:peersync/model/message.dart';
import 'package:peersync/providers/socket_manager.dart';

import '../model/user.dart';

class ChatInputEditor extends ConsumerWidget {
  final String name;
  final bool isPrivate;
  final User? receiver;
  final Channel? channel;
  ChatInputEditor(this.name, this.isPrivate, this.receiver, this.channel,
      {Key? key})
      : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();
  final bool _isItalicized = false;
  final bool _isBold = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var user = ref.read(userProvider);
    // var found = getUser();
    // print('found user in chat editor: $user  found: $found');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: _textEditingController.text.isEmpty
          ? 100.0
          : _textEditingController.text.length < 500
              ? 10.0 + 20 * _textEditingController.text.length
              : 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: 'Share all kind of files',
                onPressed: () {},
                icon: const Icon(Icons.attach_file, color: Colors.black),
              ),
              IconButton(
                tooltip: 'Record and share audio',
                onPressed: () {},
                icon: const Icon(Icons.mic, color: Colors.black),
              ),
              IconButton(
                tooltip: 'Record and share a video',
                onPressed: () {},
                icon: const Icon(Icons.videocam, color: Colors.black),
              ),
              IconButton(
                color: Colors.amber,
                tooltip: 'Pick emoji to share',
                onPressed: () {},
                icon:
                    const Icon(Icons.emoji_emotions_sharp, color: Colors.amber),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                controller: _textEditingController,
                maxLines: null, // Allows for unlimited lines
                style: TextStyle(
                  color: Colors.black,
                  fontStyle:
                      _isItalicized ? FontStyle.italic : FontStyle.normal,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                ),
                decoration: InputDecoration(
                    hintText: 'Type your message for $name',
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    )),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _sendMessage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[900],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.send),
                SizedBox(
                  width: 5.0,
                ),
                Text('Send')
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    // var shpref = await SharedPreferences.getInstance();
    var user = await getUser();
    print('send a message to backend');
    SocketManager manager = SocketManager();
    String content = _textEditingController.text;
    print('is private:  $isPrivate');
    if (content.isNotEmpty) {
      // Send the message to the server
      var message = Message(
          content: content,
          receiver: receiver,
          channel: channel,
          sender: user,
          files: [],
          reactions: [],
          mentions: [],
          readBy: [],
          createdAt: DateTime.now(),
          isPrivate: isPrivate);
      // var msg = message.toJson();
      print('formatted message ${message.toJson()}');
      var payload =
          EventPayload(type: EventType.NEW_MESSAGE, data: message.toJson());
      manager.emitMessage(payload);
      _textEditingController.clear();
    }
  }
}
