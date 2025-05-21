import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:peersync/providers/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/message.dart';
import '../model/user.dart';
import 'user_avatar.dart';

class MessageItem extends ConsumerStatefulWidget {
  final Message message;
  const MessageItem({super.key, required this.message});

  @override
  ConsumerState<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends ConsumerState<MessageItem> {
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    final message = widget.message;

    if (user == null) {
      SharedPreferences.getInstance().then((prefs) {
        String? userString = prefs.getString('user');
        if (userString != null) {
          final newUser = User.fromJson(jsonDecode(userString));
          ref.read(userProvider.notifier).state = newUser;
        }
      });
    }

    final isSender = user?.id == message.sender.id;

    const double cardWidth = 400;
    final avatar = UserAvatar(user: message.sender);

    final nameAndTime = Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(message.sender.firstName, style: textStyle()),
        const SizedBox(width: 8.0),
        Text(
          _formatTimestamp(message.createdAt!),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );

    final messageBody = SizedBox(
      width: cardWidth - 80,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          nameAndTime,
          const SizedBox(height: 8.0),
          SelectableText(widget.message.content, style: textStyle()),
          if (widget.message.files!.isNotEmpty)
            _buildFilePreview(widget.message.files!),
          const SizedBox(height: 8.0),
          if (widget.message.reactions != null)
            _buildReactions(widget.message.reactions!),
        ],
      ),
    );

    final card = SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 0.4,
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: isSender
                ? [
                    Expanded(child: messageBody),
                    const SizedBox(width: 8),
                    avatar
                  ]
                : [
                    avatar,
                    const SizedBox(width: 8),
                    Expanded(child: messageBody)
                  ],
          ),
        ),
      ),
    );

    final contextMenu = Padding(
      padding: EdgeInsets.only(
        left: isSender ? 0 : 8.0,
        right: isSender ? 8.0 : 0,
      ),
      child: _buildContextMenu(widget.message),
    );

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isSender
              ? [if (isHovered) contextMenu, card]
              : [card, if (isHovered) contextMenu],
        ),
      ),
    );
  }
}

Widget _buildContextMenu(Message message) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    ),
    child: Container(
      color: Colors.grey.shade200,
      child: PopupMenuButton<String>(
        color: Colors.white,
        offset: const Offset(0, 40),
        icon: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('😊', style: TextStyle(fontSize: 18)),
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          ],
        ),
        onSelected: (value) {
          // Handle context menu actions here
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'add_reaction',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('❤️', style: TextStyle(fontSize: 20)),
                Text('👍', style: TextStyle(fontSize: 20)),
                Icon(Icons.emoji_emotions_sharp, color: Colors.amber),
                Icon(Icons.add, color: Colors.black),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'copy',
            child: Row(
              children: [
                Icon(Icons.copy_sharp, color: Colors.black),
                SizedBox(width: 5.0),
                Text('Copy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'reply',
            child: Row(
              children: [
                Icon(Icons.reply_sharp, color: Colors.black),
                SizedBox(width: 5.0),
                Text('Reply',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_sharp, color: Colors.black),
                SizedBox(width: 5.0),
                Text('Delete',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'pin',
            child: Row(
              children: [
                Icon(Icons.push_pin_sharp, color: Colors.black),
                SizedBox(width: 5.0),
                Text('Pin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'forward',
            child: Row(
              children: [
                Icon(Icons.forward_sharp, color: Colors.black),
                SizedBox(width: 5.0),
                Text('Forward',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFilePreview(List<MessageFile> files) {
  // Placeholder: Implement file preview logic as needed
  return const Text('File Preview');
}

Widget _buildReactions(List<MessageReaction> reactions) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: reactions
        .map((reaction) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(reaction.reaction),
            ))
        .toList(),
  );
}

String _formatTimestamp(DateTime timestamp) {
  return DateFormat.jm().format(timestamp);
}

TextStyle textStyle() {
  return const TextStyle(color: Colors.black);
}
